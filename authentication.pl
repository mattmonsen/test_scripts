#!/usr/bin/perl

plugin 'authentication' => {
    session_key => 'mojotask',
    stash_key   => 'auth',
    load_user   => sub {
        my $self = shift;
        my $uid = shift;
        my $sth = $self->dbh->prepare('SELECT * FROM user WHERE id = ?');
        $sth->execute($uid);
        if (my $res = $sth->fetchrow_hashref) {
            return $res;
        } else {
            return undef;
        }
    },
    validate_user => sub {
        my $self = shift;
        my $user = shift;
        my $pass = shift;
        my $sth = $self->dbh->prepare('SELECT * FROM user WHERE username = ?');
        $sth->execute($user);
        if (my $res = $sth->fetchrow_hashref) {
            my $salt = substr($res->{'password'}, 0, 2);
            return (crypt($pass, $salt) eq $res->{'password'})
                ? $res->{'id'}
                : undef;
        } else {
            return undef;
        }
    },
};
