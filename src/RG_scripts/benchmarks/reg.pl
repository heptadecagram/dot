#!/usr/bin/perl

use strict;
use warnings;

use Benchmark qw(cmpthese);

my $Base = 'Moses supposes his toses are roses, but Moses supposes erroneously';
my $Result;

cmpthese(-1,
	{
		num => sub { $Base =~ /(usly)$/; $Result = $1; },
		amp => sub { $Base =~ /usly$/; $Result = $&; },
		con => sub { $Base =~ /usly$/; $Result = 'usly'; },
	}
);
