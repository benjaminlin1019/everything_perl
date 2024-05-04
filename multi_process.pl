#!/usr/bin/perl
use Carp;
use IO::Select;

sub get {
    our (%seen, $procs, $s);
    my $uris = shift;
    open my $fh, "./get.pl $uris |" or croak "can’t fork";
    $seen{$uris}++;
    $procs++;
    $s->add($fh);
}

sub process {
    our (@list, %seen, $procs, $s);
    my $fh = shift;
    my $line = <$fh>;
    chomp $line;
    if ($line eq "done") {
        close $fh;
        $s->remove($fh);
        $procs--;
    } else {
        push @list, $line unless defined $seen{$line};
    }
}

sub main {
    our @list = @_;
    our %seen;
    our $procs = 0;
    our $s = IO::Select->new();
    while (1) {
        while (@list > 0 && $procs < 6) {            
            get shift @list;
        }
        my @ready = $s->can_read;
        foreach my $fh (@ready) {
            process $fh;
        }
        last if (@list == 0 && $procs == 0);
    }
}

main @ARGV;