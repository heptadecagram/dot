#!/usr/bin/perl
# Project  Name: None
# File / Folder: und.pl
# File Language: perl
# First Created: 2005.10.18 08:12:10
# Last Modified: 2005.10.18 08:13:43

use strict;
use warnings;

my $undef = undef;
my $one = 1;
my $zero = 0;


print "-&&1\n" if(defined($undef && $one) );
print "0&1\n" if(defined($zero & $one) );
print "0&&1\n" if(defined($zero && $one) );
