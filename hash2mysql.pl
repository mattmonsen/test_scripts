#!/usr/bin/perl 

use warnings;
use strict;

sub fields {
    my $self = shift;
    return $self->{'fields'} ||= do {
        my $fields;
        my $sth = $self->dbh->prepare('DESC TABLE');
        $sth->execute;
        while (my $rec = $sth->fetchrow_hashref) {
            push @$fields, $rec->{'Field'};
        }
        $fields;
    }
};

sub hash2mysql {
    my $self = shift;
    my $hash = shift || {};
    my (@fields, @values);
    my $table_fields = $self->fields;
    foreach my $field (sort @$table_fields) {
        if (exists $hash->{ $field }) {
            push @fields, "TABLE.$field";
            push @values, $hash->{ $field };
        }
    }
    return (\@fields, \@values);
};

sub insert {
    my $self = shift;
    my $args = shift || return undef;
    my ($fields, $values) = $self->hash2mysql($args);
    my $field_string = '(' . join(', ', @$fields) . ')';
    my $value_string = '(' . join(', ', map({ '?' } @$fields)) . ')';
    my $sql = qq{
        INSERT INTO TABLE
            $field_string
        VALUES
            $value_string
    };
    my $sth= $self->dbh->prepare($sql);
    $sth->execute(@$values);
    return 1;
};

sub update {
    my $self = shift;
    my $args = shift || return undef;
    my $id = delete $args->{'id'} || return undef;
    my ($fields, $values) = $self->hash2mysql($args);
    my $update_string = join(",\n", map { "$_ = ?" } @$fields);
    my $sql = qq{
        UPDATE TABLE 
           SET $update_string
         WHERE id = ?
    };
    $self->dbh->do($sql, {}, @$values, $id);
    return 1;
};
