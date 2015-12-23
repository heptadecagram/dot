#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my $Reference = [ 0, 1, 2, 3, 4, 5, 6, ];
my $result;

cmpthese(-1,
	{
		arrow => sub { $result = $Reference->[$_] for(0 .. @$Reference-1); },
		dollr => sub { $result = $$Reference[$_] for(0 .. @$Reference-1); },
	},
);
