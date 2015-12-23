#!/usr/bin/perl
# Project  Name: None
# File / Folder: qb.pl
# File Language: perl
# First Created: 2005.03.10 10:18:30
# Last Modified: 2005.03.10 10:23:58

use strict;
use warnings;

$" = ',';
$, = ',';

my %hash = (
	'shift' => 'shiftkey',
	'jump' => 'jumpkey',
	'log' => 'logkey',
	'poop' => 'poopkey',
);

sub jump {
	print "jumping: @_\n";
}

sub wook {
	print $hash{shift}, "\n";
}

wook('log');

print "logging: ", $hash{log}, "\n";
print "jumping: ", $hash{jump}, "\n";

print "slicing: ", @hash{log, jump}, "\n";
