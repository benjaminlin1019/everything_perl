#!/usr/bin/perl
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

    # for larger hash, better to pass hash as reference
    my $hash;
    print_hash(\%hash);

    # test reverse hash key-value to value-key
    my %hash;
    for (1..10){
        $hash{$_} = $_+10;
    }

    print("Inverted hash\n ");
    my %new_hash = invert_hash(%hash);
    foreach my $k (keys %new_hash) {
        print("$k => $new_hash{$k}\n");
    }
}

# if all values in the hash is unique, then the hash is invertible,
# we can invert key-value pair to value-key pair hash from following
sub invert_hash {    
    my %new_hash = reverse @_;
    return %new_hash;
}


sub print_hash {
    my $myhash = shift;
    while ((my $key, my $value) = each %$myhash){
        print "%key => $value\n";
    }
}

hash_fun()