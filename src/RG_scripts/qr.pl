#!/usr/bin/perl
# Project  Name: None
# File / Folder: qr.pl
# File Language: perl
# First Created: 2005.05.04 14:21:48
# Last Modified: 2005.05.04 14:34:37


use strict;
use warnings;

use Data::Dumper;

my $s = qr#I am a regex#i;
my $o = q#I am a string#;

print Dumper($s, ref $o);
