#!/usr/bin/perl
use Carp;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use URI;
use FILE::Basename qw(dirname);
use HTML::Parser;
use Data::Dumper;

my $uris = shift;
exit 1 if !$uris;
our $uri = URI->new($uris)->canonical;

my $path = $uri->path;
my $dir = $uri->authority . File::Basename::dirname $path;
my $res = system "mkdir -p $dir";
if ($res != 0) { croak "Couldn’t create directory $dir" };

my $file = $uri->authority . $path;
open FILE, ">", $file or croak "Couldn't open $file";

our $p = HTML::Parser->new(
    start_h => [\&start_tag, "tagname, attr"] );

sub start_tag {
    my ($tagname, $attr) = @_;
    # <a>
    if ($tagname eq "a") {
        my $href = $attr->{href};
        return if ($href =~ m/http/);
        my $rel = URI->new($href);
        print $rel->abs($uri);
    }
}


sub callback {
    my $line = shift;
    our $p->parse($line);
    print FILE $line;
};

# disable ssl verification
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;
my $ua = LWP::UserAgent->new;

my $request = HTTP::Request->new(GET => $uri);
my $response = $ua->request($request, \&callback);

#print(Dumper($response));

