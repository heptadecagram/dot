#!/usr/bin/perl

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
