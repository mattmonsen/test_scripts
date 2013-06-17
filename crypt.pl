#!/usr/bin/perl

use warnings;
use strict;

# Validate a user 
# Check the db for the user
# Get the salt from the hashed password in the db
# check the password with the current salt in the db and see if it matches the passed in response
sub validate_user {
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
}

# Take a given password, generate a salt for it, and return the result of crypt
sub encrypt {
    my $self = shift;
    my $pass = shift;
    my @letters = ('A' .. 'Z', 'a' .. 'z', '0' .. '9', '/', '.');
    my $salt = $letters[rand @letters] . $letters[rand @letters];
    return crypt($pass, $salt);
};
