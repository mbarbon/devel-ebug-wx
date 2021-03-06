package Devel::ebug::Wx::Command::Standard;

use strict;
use Wx::Spice::Plugin qw(:plugin);

use Wx qw(wxOK wxVERSION_STRING);

sub commands : MenuCommand {
    return
      ( file_menu => { tag      => 'file',
                       label    => 'File',
                       priority => 0,
                       },
        help_menu => { tag      => 'help',
                       label    => 'Help',
                       priority => 10000,
                       },
        load_file => { sub      => \&load_file,
                       menu     => 'file',
                       label    => 'Load file',
                       priority => 10,
                       },
        quit      => { sub      => \&quit,
                       menu     => 'file',
                       label    => 'Exit',
                       priority => 1000,
                       },
        about     => { sub   => \&about,
                       menu  => 'help',
                       label => 'About...',
                       },
        );
}

sub quit {
    my( $sm ) = @_;

    $sm->ebug_wx_service->Close;
}

sub about {
    my( $sm ) = @_;

    my $message = sprintf <<EOT,
ebug_wx %s, (c) 2007 Mattia Barbon
wxPerl %s, %s
EOT
        Devel::ebug::Wx->VERSION, $Wx::VERSION, wxVERSION_STRING;
    Wx::MessageBox( $message, "About wxebug", wxOK, $sm->ebug_wx_service );
}

sub load_file {
    my( $sm ) = @_;
    # FIXME better file selector, add arguments
    my $file = Wx::FileSelector( "Select a Perl file" );
    if( defined $file ) {
        $sm->ebug_publisher_service->load_program( [ $file ] );
    }
}

1;
