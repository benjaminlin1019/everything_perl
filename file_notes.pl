#!/usr/bin/perl
use List::Util qw( min max);
use Cwd qw(abs_path);

sub file_fun() {

    # play with username.csv
    my $file = "username.csv";
    my $path = abs_path();
    open($fh, "<", "$path/everything_perl/username.csv");
    $total = 0;
    @all_ids = ();
    while ($line = <$fh>){
        chomp $line;
        next if $line =~ "Identifier";
        @data = split(';', $line);
        $total += $data[1];
        push(@all_ids, $data[1]);
        print "@data\n";
    }
    print "Total: $total\n";
    my $minv = min @all_ids;
    print "Min: $minv\n";
    print "Max: ", max @all_ids, "\n";

    # read entire directory files.
    $dir = "/usr/share/dict";
    my @files = glob "$dir/*";
    my $no_of_files = @files;
    print "number of files: $no_of_files\n";
    foreach my $file (@files) {
        if (-d $file) {
            print "directory!\n"; 
        }
        else{
            print "$file\n";
            # if ($file == "words") {
            #     open($fh, "<", "$file");
            #     foreach my $word (<$fh>) {
            #         print "$word\n";
            #     }
            # }

        }
    }  
    
}

file_fun();