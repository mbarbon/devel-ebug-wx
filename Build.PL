#!/usr/bin/perl -w

use strict;

use Module::Build;

my $build = new Module::Build
    ( module_name => 'Devel::ebug::Wx',
      author      => 'Mattia Barbon <mbarbon@cpan.org>',
      license     => 'perl',
      requires    => { 'Wx'                    => 0.61,
                       'Wx::STC'               => 0,
                       'Wx::Spice'             => 0.10,
                       'Class::Accessor'       => 0.27,
                       'Class::Publisher'      => 0.20,
                       'Devel::ebug'           => 0.47,
                       'YAML'                  => 0.60,
                       'Devel::Symdump'        => 2.07,
                       'Wx::Perl::TreeView'    => 0.02,
                       'Devel::StackTrace'     => 1.14,
                       },
      build_requires => { 'Test::UseAllModules' => 0,
                          'Test::Differences'   => 0,
                          },
      create_makefile_pl => 'passthrough',
      no_index           => { package =>
                              [ 'DB',
                                ],
                              },
    );

$build->create_build_script;
