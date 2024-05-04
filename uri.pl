#!/usr/bin/perl
use URI;

sub main {
    my $uris = shift || "http://www.slashdot.com";
    my $uri = URI->new($uris)->canonical;
    $uris = $uri->as_string;
    print "$uris\n";
}

main @ARGV;

