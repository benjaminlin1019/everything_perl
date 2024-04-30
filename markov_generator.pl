#!/usr/bin/perl
use warnings;
use strict;
use Time::HiRes qw(usleep nanosleep);
use utf8;
use Text::Unidecode;
use Cwd qw(abs_path);

our @prefix;  # store currently seen two words
our %hash;    # Markov hash that key is two words and value is an array storing all words appear after the two words from the key.
our %prefix_sum;

sub read_file {
    my $file = shift;
    my $subref = shift || \&read_line;
    my $fh;
    open $fh, $file or die "$file can not be opened, $!";
    while (my $line = <$fh>) {
        chomp $line;
        $subref->($line);
    }
}

sub read_line {
    my $line = shift;
    my $triple_words = shift || \&triple_words_using_hash_count;
    my @words = split " ", $line;
    foreach my $word (@words) {
        $word =~ s/[,"'.]//g;
        $word = unidecode($word);
        $triple_words->($word);
    }
}

sub triple_words {    
    our(@prefix, %hash);
    my $word = shift;

    if (@prefix == 2) {
        my $key = join " ", @prefix;
        my $arr_ref = $hash{$key};
        push @$arr_ref, $word;
        $hash{$key} = $arr_ref;
        shift @prefix; # remove the first element
    }
    push @prefix, $word; # append current word to prefix
}

# using string in the value
sub triple_words_using_string {
    our(@prefix, %hash);
    my $word = shift;

    if (@prefix == 2) {
        my $key = join " ", @prefix;
        $hash{$key} .= $word . " ";        
        shift @prefix; # remove the first element
    }
    push @prefix, $word; # append current word to prefix
}

# using hash to count the frequency of the words in suffix.
sub triple_words_using_hash_count {
    our(@prefix, %hash);
    my $word = shift;

    if (@prefix == 2) {
        my $key = join " ", @prefix;
        $hash{$key}{$word}++;
        shift @prefix; # remove the first element
    }
    push @prefix, $word; # append current word to prefix
}

#############
# Generator #
#############

sub rand_elt {$_[rand @_]}  # first $_ is input, @_ is the input but in array form so the rand @_ will evaluate @_ as array size.
# this data struture is used to store the prefix sum of each suffix list weight sum mapping to the ascending frequency order of the suffix 
# For example:
# {"a": 9, "b": 2, "c": 5}
# so the suffix sum will start with 2, and 2+5 and 2+5+9
# %prefix_sum = {"my word": [2, 7, 16]}
# this prefix sum array will then be used to do the random selection by using the binary search technique for the words to be returned in their 
# corresponding probability based the frequency.
# For example: if a random number between 1 to 16, shows 3, then the "c" will be choosen, if random number shows up 10 (between 8 ~ 16), then "a" 
# will be choosen.
 

sub build_prefix_sum {    
    our %hash;
    our %prefix_sum;
    while ((my $prefix, my $words) = each %hash) {
        my @sorted_words = sort {$words->{$a} <=> $words->{$b}} keys %$words;
        my $total = 0;
        my @res;
        foreach my $word (@sorted_words) {
            $total += $words->{$word};
            push @res, $total;
        }
        $prefix_sum{$prefix} = \@res;
    }    
}


# select a word from the array based on frequency and probability.
sub rand_select_word {
    my $prefix = shift;
    my $words = $hash{$prefix};
    my $prefix_array = $prefix_sum{$prefix};

    my @sorted_words = sort {$words->{$a} <=> $words->{$b}} keys %$words;
    my $sum = 0;
    for my $word (keys %$words) {
        my $freq = $words->{$word};
        $sum += $freq;
    }
    my $index = binary_search($prefix_array, $sum);
    return $sorted_words[$index];
}

sub binary_search {
    my $number_array = shift;
    my $sum = shift;
    my $rnum = int(rand($sum));
    my $left = 0;
    my $right = @$number_array-1;
    my $mid;
    my $avalue;
    while ($left < $right) {
        $mid = int(($left + $right)/2);
        $avalue = int($number_array->[$mid]);
        if ($avalue < $rnum) {
            $left += 1;
        }
        else {
            $right = $mid
        }    
    }
    return $left;
}


sub random_text {
    my $prefix = rand_elt keys %hash;
    my $cnt = 0;
    my $text = "";
    while(1) {
        my $word = rand_select_word($prefix);
        #print ("New word: $word\n");
        $text .= $word . " ";

        my @triple = split " ", $prefix;
        shift @triple;
        $prefix = "@triple $word";
        #print ("New prefix: $prefix\n");
        #usleep(50000);
        #print("$text\n\n");
        last if !defined $hash{$prefix};        

        # Stop after some generation because highly frequent words may form a repated cycle and falling into a infinite circle of repeated
        # sentences being generated.
        last if $cnt++ > 10000;
    }    
    return $text . "\n";
}

my $file = "the_great_gatsby.txt";
my $path = abs_path();
read_file("$path/everything_perl/$file");
build_prefix_sum();
print(random_text());
