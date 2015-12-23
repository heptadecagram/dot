#!/usr/bin/perl

use strict;
use warnings;

my @list = ();

my $k = (grep {$_ == 0} @list)[0];

print $k
