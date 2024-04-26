#!/usr/bin/perl
use strict;
use warnings;

sub abcgrep {
    my $pattern = shift;
    my @files = @_;
    print("files @files\n");
    foreach my $file (@files) {
        if (not -d $file){
            my $fh;
            open $fh, $file;
            while (my $line = <$fh>) {
                if ($line =~ m/$pattern/) {
                    print("$line matched!\n");
                }
            }
        }
    }
}

abcgrep(@ARGV);

1;