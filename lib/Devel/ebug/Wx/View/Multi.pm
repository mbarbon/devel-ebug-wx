package Devel::ebug::Wx::View::Multi;

use strict;
use base qw(Devel::ebug::Wx::View::Base);

__PACKAGE__->mk_accessors( qw(_tag _index) );

sub abstract     { $_[0] eq __PACKAGE__ }
sub is_multiview { 1 }

sub description {
    my( $self ) = @_;
    my $description_base = $self->description_base;

    return $description_base unless ref $self;
    $self->tag; # hack to set _index...
    return sprintf "%s %d", $description_base, $self->_index;
}

sub tag {
    my( $self ) = @_;
    my $tag_base = $self->tag_base;

    return $tag_base unless ref $self;
    return $self->_tag if $self->_tag;
    # generate an unused tag
    my $vm = $self->wxebug->view_manager_service;
    for( my $index = 1; $index < 1000; ++$index ) {
        my $tag = $tag_base . $index;
        next if $vm->has_view( $tag );
        $self->_index( $index );
        return $self->_tag( $tag );
    }
}

sub save_state { $_[0]->tag }
sub load_state {
    my( $self, $state ) = @_;

    $self->_tag( $state );
}

1;

