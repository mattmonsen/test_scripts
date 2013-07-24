#!/usr/bin/perl

use warnings;
use strict;

=head1 DESCRIPTION

Using single quotes when using here-document does not use interpolation.

Here is an example of hear-document with single quotes

=cut 

my $name = 'Foo';
my $message = <<'END_MESSAGE';
Dear $name

this is a message I plan to send you.

regards,
  Matt
END_MESSAGE

print $message;

=head1 DESCRIPTION

Using double quotes when using here-document does use interpolation.
You can also use no quotes and it will default to double quotes

Here is the same example as above using interpolation

=cut

$message = <<"END_MESSAGE";
Dear $name

this is a message I plan to send you.

regards,
  Matt
END_MESSAGE

print $message;

=head1 Description

Using q or qq instead of here-document

this example uses qq to allow interpolation, use q to prevent 
interpolation

=cut

$message = qq{
Dear $name

this is a message I plan to send you.

regards,
  Matt
};

print $message;
