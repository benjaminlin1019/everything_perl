#!/usr/bin/perl

sub reverse_list {
    for (my $i = 0; $i < @_/2; $i++) {
        (@_[$i], @_[-$i-1]) = (@_[-$i-1], @_[$i])
    }
    return @_;
}

@list1 = (1..5);
print reverse_list(@list1), "\n";

@list1 = (1);
print reverse_list(@list1), "\n";

@list1 = (1..4);
print reverse_list(@list1), "\n";
print (reverse @list1);