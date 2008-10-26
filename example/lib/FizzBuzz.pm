package FizzBuzz;

use strict;

sub fizzbuzz {
    my( $v ) = @_;

    return   ( $v % 3 == 0 ? 'fizz' : '' )
           . ( $v % 5 == 0 ? 'buzz' : '' );
}

1;
