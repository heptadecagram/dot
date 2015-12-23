#!/usr/bin/perl

use strict;
use warnings;

local $_ = " babyeel babyradish babyhorse quickstep babysteps ";

$_ = reverse;
s#(\S+)ybab (?=(?:\S+)ybab)#$1 #g;
$_ = reverse;

print "$_\n";

s#<ol>([^\n]+)\n(?!<ol>)##;
