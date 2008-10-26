#!/usr/bin/perl -w

use strict;
use lib 'example/lib';

use FizzBuzz;

print STDOUT "Stdout\n";
print STDERR "Stderr\n";
my $f = fib( 5 );
my $out;
foreach my $v ( 1 .. 20 ) {
    my $fb = FizzBuzz::fizzbuzz( $v );
    $out .= $fb || $v;
} continue {
    $out .= ' ';
}
# not break
print $out, "\n";
# not break
exit 0 if $f;

sub fib {
    my $x = shift;

    return $x == 0 ? 1 :
           $x == 1 ? 1 :
                     fib( $x - 1 ) + fib( $x - 2 );
}
