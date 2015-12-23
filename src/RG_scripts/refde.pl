#!/usr/bin/perl

use strict;
use warnings;

my @columns = (1 .. 10);

use Benchmark 'cmpthese';

my @A = (1 .. 10);
my @B = (1 .. 500);
my @C = (1 .. 10000);

print A(\@C);
print "\n";
print B(\@C);
print "\n";

cmpthese(-1,
	{
		short => 'A(\@A)',
		shortref => 'B(\@A)',
		med => 'A(\@B)',
		medref => 'B(\@B)',
		long => 'A(\@C)',
		longref => 'B(\@C)',
	}
);

sub A {
	my $ref = shift;
	1+scalar(@$ref);
}
sub B {
	my $ref = shift;
	1+$#{$ref}
}
