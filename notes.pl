#!/usr/bin/perl
use List::Util qw( min max);

##########
# String #
##########
sub string_fun {
    @String = qw/Ram is a boy/;

    foreach my $str (@String) {
        print "$str\n";
    }

    print "$String[0]\n";

    $employee_name = "Ben";
    $employee_age = 23;
    $employee_salary = 440.5;

    print "$employee_name\n";
    print "$employee_age\n";
    print "$employee_salary\n";

    $a = "potato";
    $b = "head";

    print $a . $b . "\n";
    # increment string potato -> potatp  o next is p
    $a++;
    print $a . "\n";

    # repeat 
    $new_a = $a x 5;
    print "$new_a\n";

    # matching
    $string = "perl tutorials by Ben";
    $string =~ m/by/;
    print "Before: $`\n";
    print "Macthed: $&\n";
    print "After: $'\n";

    # substitution only replace first match
    $string =~ s/Ben/James/;
    print "$string\n";

    # transliterate tr replace all matches
    $string = "James is James";
    print "$string\n";
    $string =~ tr/(James)/Ben/s;
    print "$string\n";
}

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

########
# Hash #
########
sub hash_fun {
    #%emp_data = ('A', 1, 'B', 2, 'C', 3);
    %emp_data = ('A' => 1, 'B' => 2, 'C' => 3);
    print "\$emp_data{'A'} = $emp_data{'A'}\n";

    my @keys = qw/a b c d/;
    my %hash;
    # build a ? set, more like a hash but all keys do not have values
    @hash{@keys} = ();

    # iterate hash method 1
    foreach my $key (keys %hash) {
        print "$key - $hash{$key}\n";
    }

    # iterate hash method 2, "each" will remember when the last position of reading the same hash, 
    # and continue from there, so there maybe side effect
    while ( my ($key,$val) = each %hash ) {
        # continues where the last loop left off
        print "$key => $val\n";
    }

    foreach my $value (values %hash) {
        print "$value\n";
    }

    # check key exists
    if (exists $hash{"a"}) {
        print "Exists!!!\n";
    }
    else {
        print "Not Exists!!!\n";
    }

    # check values is defined 
    if (defined $hash{"a"}) {
        print "Defined!!!\n";
    }else {
        print "Not Defined!!!\n";
    }

    # pre-allocate hash size
    keys(%users) = 512;
    $size = keys %users;

}
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

sub file_fun() {

    # play with username.csv
    open($fh, "<", "username.csv");
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

# sub routine fun
sub grep_file {
    my $pattern = shift;
    my $file = shift;

    open FILE, $file;
    my $cnt = 0;
    print "pattern: $pattern\n";
    while( my $line = <FILE>) {
        #print "$line\n";
        $cnt += 1;
        if ($cnt % 50000 == 0) {print "proceed $cnt\n";}
        if ($line =~ m/$pattern/) {print "$line\n";}
    }
}



sub regular_expr_fun {
    # Quantifiers
    # ab{2} match abb
    # (ba){2} match baba
    # (.es.){3} match “restlessness”
    # grep_file("(.es.){3}", "/usr/share/dict/words");

    # ? match 0 or one time.
    # (un)?usual match usual and unusual
    # grep_file("^(un)?usual\$", "/usr/share/dict/words");

    # + appear one or more times.
    # * appear zero or many times.

    # g global,
    # r non-destructive substitution modifier, this won't change the original string
    # my $oldstring = "foo";
    # my $newstring = $oldstring =~ s/foo/bar/gr; 
    # print("oldstring: $oldstring, newstring: $newstring\n");

    # \d match any number eq [0-9]
    # \s match any space
    # \w match any character, upper/lower/digit/underscore/
    
    # minimal matching (.*?) 
    # separate domain name and the file paths. http://www.gnu.org/philosophy/free-sw.html
    # ex: result is http, www.gnu.org and philosophy/free-sw.html
    # $url = 'http://www.gnu.org/philosophy/free-sw.html';
    # $pattern = '(http)://(.*?)/(.*)';
    # if ($url =~ m/$pattern/) {print "1: $1, 2: $2, 3: $3\n"};

    # Exercises:    
    my $exe_pat;
    # $ exe_pat = '^(pre)\w*(al)$'
    
    # Find all the words that begin with a|b and end with a|b. The list should include
    # “adverb” and “balalaika”.
    # $ exe_pat = '^(a|b)\w*(a|b)$';

    # Find all the words that either start and end with a or start and end with b. The
    # list should include “alfalfa” and “bathtub”, but not “absorb” or “bursa”
    # $ exe_pat = '(^a\w*b$|^b\w*a$)';

    # Find all the words that begin with un or in and have exactly 17 letters
    # $ exe_pat = '^(un|in)\w{15}$';

    # Find all the words that begin with un or in or non and have more than 17 letters
    # $ exe_pat = '^(?:un|in|non)\w{17,}$';

    # Write a regular expression that matches all lines that begin and end with the same character.
    $exe_pat = '^(.).*\1$';
    grep_file($exe_pat, "/usr/share/dict/words");
}

# string_fun();
# list_fun();
# hash_fun();
# misc_fun();
# file_fun();
regular_expr_fun();