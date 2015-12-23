#!/usr/bin/perl
# Project  Name: None
# File / Folder: concat.pl
# File Language: perl
# First Created: 2004.12.01 11:09:27
# Last Modified: 2005.02.18 09:48:02

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
