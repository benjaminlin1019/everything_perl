#!/usr/bin/perl
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

regular_expr_fun();