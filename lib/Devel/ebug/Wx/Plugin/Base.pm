package Devel::ebug::Wx::Plugin::Base;

use strict;
use Exporter qw(import);

our @EXPORT = qw(MODIFY_CODE_ATTRIBUTES);

my %attributes;

sub MODIFY_CODE_ATTRIBUTES {
    my( $class, $code, @attrs ) = @_;
    my( @known, @unknown );

    foreach ( @attrs ) {
        /^(?:Service|Command|View|Configuration)\s*(?:$|\()/ ?
          push @known, $_ : push @unknown, $_;
    }

    $attributes{$class}{$code} = [ $code, \@known ];

    return @unknown;
}

our $AUTOLOAD;

sub AUTOLOAD {
    ( my $method = $AUTOLOAD ) =~ s/.*:://;
    return if $method eq 'DESTROY';

    return _instantiators( $method );
}

sub _instantiators {
    my( $name ) = @_;
    $name =~ s/s$//;

    my @rv;
    foreach my $c ( keys %attributes ) {
        my $class = $c;
        foreach my $v ( values %{$attributes{$c}} ) {
            my( $code, $attrs ) = @$v;
            next unless grep lc( $_ ) eq $name, @$attrs;
            push @rv, sub {
                $code->( $class, @_ );
            };
        }
    }

    return @rv;
}

1;
