#!/ramdisk/bin/perl

use Email::MIME;
use Email::Simple;
use Image::Magick;

my $message;

while(<STDIN>) { $message .= $_; }

my @email= <STDIN>;
my $time = time;

my $parsed = Email::MIME->new($message);
my @parts = $parsed->parts; 

foreach my $part (@parts) {
    if ($part->filename) {
        my $filename = $part->filename;
        open(ATTACHMENT, "> /path/to/attachment/$time.jpg");
        print ATTACHMENT $part->body;
        close(ATTACHMENT);
    }
}

open(NEWEMAIL, "> /path/to/image/folder/$time");

$email = Email::Simple->new($message);
print NEWEMAIL $email->as_string;
close(NEWEMAIL); 

@names = $email->header_names;

my $image = Image::Magick->new;
$image->Read("/path/to/public/images/$time.jpg");
$image->Resize(geometry=>'100x100');
$image->Write("/path/to/public/images/thumbs/tn_$time.jpg");
