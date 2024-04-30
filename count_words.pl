#!/usr/bin/perl
use utf8;
use Text::Unidecode;
use Cwd qw(abs_path);

sub read_line {
    our %words_count;
    my $line = shift;
    chomp $line;
    @words = split " ", $line;
    foreach (@words) {
        chomp;
        $_ =~ s/[,"'.]//g;
        $word = unidecode($_);
        $words_count{$word}++;
    }
}

sub read_file {
    our %words_count;
    my $file = shift;
    my $subref = shift || \&read_line;
    open FILE, $file;    
    while (my $line = <FILE>) {
        $subref->($line);        
    }
}

sub build_dict {
    %dict;
    open DICT, "/usr/share/dict/words";
    while (my $line = <DICT>) {
        chomp;
        $dict{$line}++;
    }
    return %dict;
}

my $file = "the_great_gatsby.txt";
my $path = abs_path();
$file = "$path/everything_perl/$file";
print "$file exists!\n" if -e $file;

%words_count;
read_file($file);
%mydict = build_dict();

@sorted_words = sort {$words_count{$b} <=> $words_count{$a}} keys %words_count;
$top_20 = 20;
for my $word (@sorted_words) {
    last if $top_20 == 0;
    $top_20--;    
    print "{$word}: $words_count{$word}\n";
}

for my $word (@sorted_words) {
    print "$word is not in Dict!\n" if !defined $mydict{$word};
}
