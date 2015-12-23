#!/usr/bin/perl
# Project  Name: None
# File / Folder: callback.pl
# File Language: perl
# First Created: 2005.02.25 10:12:18
# Last Modified: 2005.02.25 10:23:11

use strict;
use warnings;

use Data::Dumper;

sub xtc {
	print "xtc\n";
}

my $direct = \&xtc;

my $name = 'xtc';

my $indir = \&{$name};

print "$direct\n";
print "$indir\n";
print "&xtc\n";

warn Dumper(\&xtc);
warn Dumper($name);
warn Dumper($direct);
warn Dumper($indir);

&$indir;
&$direct;
&{\&{$name} };
eval "$name";
