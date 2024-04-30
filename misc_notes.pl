#!/usr/bin/perl
########
# Misc #
########
sub misc_fun {
    # chomp: function remove trailing “\n” etc.

    # $_ default variable.

    # while (<STDIN>) {
    # 	chomp;
    # 	if(/MATCH/) {
    # 		say;
    # }
    # }

    # Same as:
    # while ($_ = <STDIN>) {
    #   chomp $_;
    #   if ($_ =~ /MATCH/) {
    #      say $_;
    #   }
    # }

    # while (my $line = <$fh>) {
    #  chomp $line;
    #  my $prefix = substr $line, 0, 7;
    # }

    # sorting
    @numbers = (9,2,8,4,1);
    @sorted_num = sort @numbers;
    print ("sorted_num: ", @sorted_num, "\n");

    # sort with block, op1 <=> op2 compare two, if op1 < op2, return -1, equal return 0 and larger return 1
    @sorted_num = sort { $a <=> $b } @numbers;
    print ("Block sorted_num: ", @sorted_num, "\n");

    # sort with func reverse sorting
    @sorted_num = sort compare_reverse_sort @numbers;
    print ("Func sorted_num: ", @sorted_num, "\n");
    sub compare_reverse_sort
    {
        if($a < $b)
        {
            return 1;

        }elsif($a == $b)
        {
            return 0;
        }
        else
        {
            return -1;
        }
    };

    # using built-in reverse
    @sorted_num = reverse sort @numbers;
    print ("Func sorted_num: ", @sorted_num, "\n");

    # Reference and Dereference
    # https://www.codesdope.com/perl-references/
    # for scalar variable, dereference is $$, for array, @$, for hash, %$
    my @a = (1,2,3);
    my $b = \@a;
    print "$b\n";
    print "@$b\n";

    # -> operator is used on reference of an array or an hash
    print "$b->[0]\n";

    my %r = {'x'=>1,'y'=>2,'z'=>[1,2],'w'=>{'a'=>3,'b'=>4}};
    my $r3 = \%r;
    print "$r3->{'x'}\n";
    print "$r3->{'w'}->{'a'}\n";

    my $r = sub {
        print "I am anonymous function\n";
    };

    &$r;

    # function with parameter being called
    my $r = sub {
        my @params = @_;
        print "I am anonymous function\n";
        print "$params[0]\n";
    };

    &$r(54);

    # condition 
    $a = 22;
    unless ($a < 20){
        print ("a is greater than 20\n");
    }

    # next is just like continue
    my @arr;
    for (1..10){
        next if $_ < 5;
        push(@arr, $_);
    }    
    print ("\@arr:", @arr, "\n");

    # switch like syntax
    my $test = 'abcd';
    # in this case, "bc" will match.
    print test($test);
    sub test {
        for ($_[0]) {
            /ad/ && return "Case 1\n";
            /bc/ && return "Case 2\n";
            /c/ && return "Case 3\n";
        }
    }

    # constant
    use constant ABC => 193;
    print ABC, "\n";

    # loop
    for ($a = 10; $a < 20; $a = $a + 1) {
        print "a: $a\n";
    }

    @names = (a..z);
    $size = @names;
    for ($i = 0; $i < $size; $i = $i+1){
        print "\@names[$i], @names[$i]\n";
    }

    # arguments will automatically combine scalar and list into the @_ list.
    # ex: $x = 10, @y = (1,2,3,4) and @_ = (10,1,2,3,4)
    sub print_args {
        print "$_[0]\n";
        print "$_[1]\n";
        print "$_[2]\n";
        print "$_[3]\n";
        print "$_[4]\n";

    }
    $x = 10;
    @y = (1,2,3,4);
    print_args($x, @y);

    # $0 contains the name of the program that is running
    # $! contains a textual description of the most recent error message.
    # die "$0: Couldn’t open $file: $!\n"
    
}
misc_fun();