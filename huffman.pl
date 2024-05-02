#!/usr/bin/perl
# Learning Perl the hard way Chapter 5. Huffman coding.
# Using "The Gold Bug" short story by Edgar Allen Poe for content.
use Cwd qw(abs_path);
use Data::Dumper;

use Heap;

{
    package Pair;

    sub new {
        my $class = shift;
        my $self = {
            letter => shift,
            priority => shift,
            @_
        };
        bless $self, $class;        
    }

    sub letter {
        my $self = shift;
        if (@_) {$self->{letter} = shift;}
        return $self->{letter};
    }

    sub priority {
        my $self = shift;
        if (@_) {$self->{priority} = shift;}
        return $self->{priority};
    }    

    sub print {
        my $self = shift;
        return "$self->{letter} => $self->{priority}";
    }
}

{
    package HuffTree;
    our @ISA = "Pair";

    sub new {
        my $class = shift;
        my $self = {
            letter => shift,
            priority => shift,
            @_
        };
        bless $self, $class;        
    }

    sub left {
        my $self = shift;
        if (@_) {$self->{left} = shift}
        return $self->{left};
    }

    sub right {
        my $self = shift;
        if (@_) {$self->{right} = shift}
        return $self->{right};
    }

    # override parent method to make the heap as min-heap.
    sub priority {
        my $self = shift;
        return -$self->{priority};
    }

}

{
    package Huffman;

    sub new {
        my $class = shift;
        my $self = {
            freqtab => shift,
            hufftree => undef,
            @_ => shift
        };
        

        my $heap = Heap->new;
        # Building heap by HuffTree
        for my $letter (keys %{$self->{freqtab}}) {
            my $tree = HuffTree->new($letter, $self->{freqtab}->{$letter});
            $heap->add($tree);
        }
        
        my $tree;
        while (1) {
            my $left = $heap->remove;
            my $right = $heap->remove;
            my $freq = $left->{priority} + $right->{priority};

            $tree = HuffTree->new(undef, $freq);
            $tree->left($left);
            $tree->right($right);
            last if $heap->empty;
            $heap->add($tree);
        }
        $self->{hufftree} = $tree;        
        bless $self, $class;
    }    
    
    # Building heap by Pair
    # for my $letter (keys %$freqtab) {
    #     my $pair = Pair->new($letter, $freqtab->{$letter});
    #     $heap->add($pair);
    # }

    # while (! $heap->empty) {
    #     my $pair = $heap->remove;
    #     print($pair->print . "\n");
    # }

    
}

%codetab;
sub codetab {
    our %codetab;
    my ($tree, $path) = (@_);
    if (defined($tree->letter)) {
        $codetab{$tree->letter} = $path;
        return
    }
    codetab($tree->left, "$path.");
    codetab($tree->right, "$path-");
}

sub encode {
    our %codetab;
    my ($str) = shift;
    my $res = '';
    foreach (split "", $str) {
        $res .= $codetab{$_};
    }
    return $res;
}

sub decode {
    my ($huffman, $coded_str) = (@_);
    my $res = "";
    my $tree = $huffman;
    foreach(split "", $coded_str) {
        if($_ eq ".") {
            $tree = $tree->left;
        }
        else{
            $tree = $tree->right;
        }
        if (defined $tree->letter){
            $res .= $tree->letter;
            $tree = $huffman;
        }
    }

    return $res;
}

my $file = "the_gold_bug.txt";
my $path = abs_path();
my $fh;
open $fh, "$path/everything_perl/$file";

my %freqtab;
while (my $line = <$fh>) {
    foreach (split "", $line) {
        if ($_ =~ m/[a-zA-Z]/) {
            $freqtab{$_}++;
        }
    }
}

my $huffman = Huffman->new(\%freqtab);
# print(Dumper($huffman->{hufftree}));


codetab($huffman->{hufftree}, "");
#print(Dumper(\%codetab));

my $str = "abc";
my $encode = encode("abc");
my $decode = decode($huffman->{hufftree}, $encode);

print("my str: $str\n");
print("encode: $encode\n");
print("decode: $decode\n");