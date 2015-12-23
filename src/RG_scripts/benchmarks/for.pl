#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my $string;
my @array = (1 .. 100_000);

cmpthese(-1,
	{
		fur => sub { $string = $_ foreach(@array); },
		eab => sub { $string = $array[$_] foreach(0 .. @array-1); },
		eac => sub { $string = $array[$_] foreach(0 .. $#array); },
	}
) if(0);

cmpthese(-1,
	{
		for => sub { my @x = @array; my @y; foreach(@x){my $x = $_;$x=~s/0/./g;push @y,$x;} },
		map => sub { my @x = @array; my @y = map { s/0/./g; $_; } @x; },
	}
);
