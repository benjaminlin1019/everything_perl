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

string_fun();