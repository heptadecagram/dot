#!/usr/bin/perl
# Project  Name: None
# File / Folder: lval.pl
# File Language: perl
# First Created: 2004.11.11 14:10:52
# Last Modified: 2005.01.31 15:57:49

use strict;
use warnings;

my $doo = 0;

sub lov : lvalue {
	print $doo;

	$doo;
}

my @dah;
my $o = $dah[0];

@dah = (1,2,3,4,5);
my @dit = (6,7,8,9,0);

sub pro(\@@) {
	my @arref = @{shift()};
	my @rest = @_;
	print "@arref\n";
	print "@rest\n";
}

pro(@dit, @dah);

print @dah[0 .. 4];
print "\n";
print @dah[1 .. 4];
print "\n";
print @dah[1 .. $#dah];
print "\n";
