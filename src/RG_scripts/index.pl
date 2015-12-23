#!/usr/bin/perl
# Project  Name: None
# File / Folder: index.pl
# File Language: perl
# First Created: 2007.11.28 11:11:55
# Last Modified: 2007.11.28 11:12:26

use strict;
use warnings;

my @list = ();

my $k = (grep {$_ == 0} @list)[0];

print $k
