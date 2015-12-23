#!/usr/bin/perl

use strict;
use warnings;

my $undef = undef;
my $one = 1;
my $zero = 0;


print "-&&1\n" if(defined($undef && $one) );
print "0&1\n" if(defined($zero & $one) );
print "0&&1\n" if(defined($zero && $one) );
