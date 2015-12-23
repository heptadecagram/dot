#!/usr/bin/perl
# Project  Name: None
# File / Folder: can.pl
# File Language: perl
# First Created: 2007.09.25 09:20:13
# Last Modified: 2007.09.25 09:24:02

use strict;
use warnings;

my $x = {};

print "x can id\n" if(UNIVERSAL::can($x, 'id') );
print "x cannot plop\n" unless(UNIVERSAL::can($x, 'plop') );
