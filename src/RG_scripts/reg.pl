#!/usr/bin/perl
# Project  Name: None
# File / Folder: reg.pl
# File Language: perl
# First Created: 2005.01.10 15:42:17
# Last Modified: 2005.02.18 09:44:08

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
