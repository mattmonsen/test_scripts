#! /usr/bin/perl -w

use strict;
use IO::Socket::INET;

my $port = $ARGV[0] || 7000;
my $socket = new IO::Socket::INET(
    LocalAddr => 'bindaddress.com',
    LocalPort => $port,
    Listen => 5,
    Proto => 'tcp'
);

if($socket) {
    my $newSock;
    print "Listening for connections on port $port.\n";
    while($newSock = $socket->accept()) {   
        print "Connection from ".$newSock->peerhost." made.\n";
        while($newSock->connected) {
            $newSock->send("Connected to server on port $port.\n");
            sleep 5;
        }
        print "Client disconnected.\n";
    }
} else {
    print "Unable to open socket on port $port : $@";
}
