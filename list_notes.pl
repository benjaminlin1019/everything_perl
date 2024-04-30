#!/usr/bin/perl

########
# List #
########
sub list_fun {
    @names = ("A", "B", "C");
    @ages = (1, 2, 3);

    print "\$names[0] = $names[0]\n";
    print "\$names[-1] = $names[-1]\n";

    # slice list
    @names = ("A", "B", "C", "D");
    @new_names[0, 1] = @names[1,3];
    print "\@new_names = @new_names\n";

    my @list1 = (1..10);
    # if list in the quote, perl will auto add space to each element in the print
    print "\@list1 = @list1\n";
    # w/o quote, the list will be printed no extra space for each element.
    print (@list1);
    print "\n";

    my @sslist = (1, 5..9, 11);
    print "\@sslist = @sslist\n";

    my @chrlist = (aa..ad);
    print "\@chrlist = @chrlist\n";

    my $join_list = join(" ", @chrlist);
    print ("Join list:", $join_list, "\n");

    @join_list_back = split(/ /, $join_list);
    print ("A real list:", @join_list_back, "\n");

    while (@join_list_back){
        my $stuff = shift @join_list_back;
        print "shifted stuff: $stuff\n";
    }

    # list resize
    # enlarge
    @array = (1,2,3);
    print "size before enlarge: ", scalar @array, "\n";
    $#array = 99;  # 99 is to indicate last index of the list not the size
    print "size after enlarge: ", scalar @array, "\n";

    # shrink
    $#array = 1; # reduce to last index to 1 so only two elements allow.
    print "size after shrink: ", scalar @array, "\n";
    print "array after shrink: @array\n";
}

list_fun();