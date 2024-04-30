#!/usr/bin/perl
our $value = "away";

package Fred;
our $value = "home";
# scope under Fred package
print $value . "\n";

# scope under main
print $main::value . "\n";

# Any reference can be considered an object, but the most common kind of object
# is a reference to a hash.
my %hash;
my $hashref = \%hash;

# another way
my $nobody = { };

package Person;
my $person = { name => "Benjamin Lin",
               address => "4048 NE"};
bless $person, "Person";
