#!/usr/bin/perl -w

use strict;
use Test::UseAllModules;

BEGIN {
    require Wx::Spice::ServiceManager;
    all_uses_ok();
}

exit 0;
