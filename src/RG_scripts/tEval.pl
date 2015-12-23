#!/usr/bin/perl
# Project  Name: None
# File / Folder: tEval.pl
# File Language: perl
# First Created: 2005.06.15 08:23:22
# Last Modified: 2005.06.15 08:25:56

use strict;
use warnings;

use Benchmark 'cmpthese';

cmpthese(-1,
	{
		one => sub {
			eval "require Carp";
		},
		two => sub {
			eval "\$_++ foreach(0..100);";
		},

		ONE => sub {
			require Carp;
		},
		TWO => sub {
			$_++ foreach(0..100);
		},
	}
);
