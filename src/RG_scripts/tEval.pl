#!/usr/bin/perl

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
