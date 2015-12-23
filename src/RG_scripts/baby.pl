#!/usr/bin/perl
# Project  Name: None
# File / Folder: baby.pl
# File Language: perl
# First Created: 2005.06.21 08:32:08
# Last Modified: 2005.06.21 09:37:29

use strict;
use warnings;

local $_ = " babyeel babyradish babyhorse quickstep babysteps ";

$_ = reverse;
s#(\S+)ybab (?=(?:\S+)ybab)#$1 #g;
$_ = reverse;

print "$_\n";

s#<ol>([^\n]+)\n(?!<ol>)##;
