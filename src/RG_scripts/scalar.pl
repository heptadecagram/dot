#!/usr/bin/perl
# Project  Name: None
# File / Folder: scalar.pl
# File Language: perl
# First Created: 2006.11.16 08:47:06
# Last Modified: 2006.11.16 09:29:46

use strict;
use warnings;

my @columns = (1 .. 10);

use Benchmark 'cmpthese';

my @A = (1 .. 10);
my @B = (1 .. 100);
my @C = (1 .. 1000);

print scalar(A(@C) );
print scalar(B(@C) );
print scalar(C(@C) );
exit;


cmpthese(-1,
	{
		short => 'A(@A)',
		shortref => 'B(@A)',
		shortmap => 'C(@A)',
		med => 'A(@B)',
		medref => 'B(@B)',
		medmap => 'C(@B)',
		long => 'A(@C)',
		longref => 'B(@C)',
		longmap => 'C(@C)',
	}
);

sub A {
	return sort map { $_ ** 2 } @_;
}
sub B {
	return @{[ sort map { $_ ** 2 } @_]};
}
sub C {
	return map { $_ } sort map { $_ ** 2 } @_;
}
