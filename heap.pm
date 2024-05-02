# https://www.greenteapress.com/perl/perl.pdf
# Chapter 4.6, page 43
use POSIX;
{
    package Heap;

    sub new {
        my $class = shift;
        my $self = {
            aref => [""],
            next => 1,
            @_};

        bless $self, $class;
    }

    sub print {
        my $self = shift;
        my $next = $self->{next};
        my $aref = $self->{aref};
        my $size = @$aref;
        print "array => ";
        for my $i (1..$size) {
            my $thing = $aref->[$i];
            if ($thing) {
                print($thing->print . "\n");
            }
        };
        print "\n";
        print "next => $next\n";
    }

    sub add {
        my ($self, $value) = @_;
        my $index = $self->{next};

        # first add the element into last posisition and move it to fullfill heap property
        $self->{aref}[$index] = $value;
        while($index > 1) {
            my $parent = POSIX::floor($index/2);
            last if $self->compare($index, $parent) <= 0;
            $self->swap($index, $parent);
            $index = $parent;
        }
        $self->{next}++;
    }

    sub compare {
        my ($self, $i, $j) = @_;
        my $x = $self->{aref}[$i];
        my $y = $self->{aref}[$j];
        if (!defined $x) {
            if (!defined $y) {
                return 0;
            }else{
                return -1;
            }
        }
        if (!defined $y) {return 1;}
        return $x->priority <=> $y->priority;
    }

    sub swap {
        my ($self, $x, $y) = @_;
        my $aref = $self->{aref};
        ($aref->[$x], $aref->[$y]) = ($aref->[$y], $aref->[$x]);
    }

    sub remove {
        my $self = shift;
        my $aref = $self->{aref};
        my $result = $aref->[1];

        $aref->[1] = pop @$aref;
        $self->{next}--;

        $self->reheapify(1);
        return $result
    }

    sub reheapify {
        my ($self, $i) = @_;

        my $left = 2 * $i;
        my $right = 2 * $i+1;

        my $winleft = $self->compare($i, $left) >= 0;
        my $winright = $self->compare($i, $right) >= 0;
        # the heap property restored, return here.
        return if $winleft and $winright;

        # largest in the left    
        if ($self->compare($left, $right) > 0) 
        {
            $self->swap($i, $left);
            $self->reheapify($left);
        }
        # largest in the right
        else
        {
            $self->swap($i, $right);
            $self->reheapify($right);
        }
    }

    sub empty {
        my $self = shift;
        return $self->{next} == 1;
    }
}

{
    package Thing;

    sub new {
        my $class = shift;
        my $self = { @_ };
        bless $self => $class;        
    }

    sub print {
        my $self = shift;
        foreach my $k (keys %$self) {
            print("$k => $self->{$k}\n");
        }
    }

    sub priority {
        my $self = shift;
        if (@_) {
            my $value = shift @_;
            $sel->{priority} = $value;
        };
        return $self->{priority};
    }
}

1;