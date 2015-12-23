#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

cmpthese(-1,
	{
		'concat_e' => sub {; my $monkey = '$ylrebmik kimberly ylrebmik$';},
		'interp_e' => sub {; my $monkey = "\$ylrebmik kimberly ylrebmik\$";},
	}
);

my $kim = 'kimberly';

cmpthese(-1,
	{
		'concat_v' => sub {; my $monkey = 'ylrebmik ' . $kim . ' ylrebmik';},
		'interp_v' => sub {; my $monkey = "ylrebmik $kim ylrebmik";},
		'inter{_v' => sub {; my $monkey = "ylrebmik ${kim} ylrebmik";},
	}
);
