#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my @words = qw(_aoeu nthlraocue sntaoeu _4aueo _2339aoaeu staoeu tatoehu AOTEU);

my $ind;
my $str;

cmpthese(-1,
	{
		ind => sub { foreach(@words) { ++$ind unless(index($_, '_') );} },
		str => sub { foreach(@words) {++$ind if(substr($_, 0, 1) eq '_');}},
	},
);
