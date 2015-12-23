#!/usr/bin/perl


use strict;
use warnings;

use Data::Dumper;

my $s = qr#I am a regex#i;
my $o = q#I am a string#;

print Dumper($s, ref $o);
