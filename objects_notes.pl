#!/usr/bin/perl
use Data::Dumper;

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

################
# class Person #
################
package Person;
use Data::Dumper;

sub new {
    my $class = shift;
    my $self = { @_ };
    bless $self, $class;
}

sub name {
    my $self = shift;
    if (@_) {
        $self->{name} = shift;
    };
    return $self->{name};
}

my $person = Person->new( name => "Benjamin Lin",
                          address => "4048 NE");


# print the name of the person
print($person->name . "\n");

# update the name
$person->name("Blah");

# print the name of the person after update
print($person->name . "\n");

print(Dumper($person));