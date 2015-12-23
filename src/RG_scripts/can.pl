#!/usr/bin/perl

use strict;
use warnings;

my $x = {};

print "x can id\n" if(UNIVERSAL::can($x, 'id') );
print "x cannot plop\n" unless(UNIVERSAL::can($x, 'plop') );
