#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @array = (4 .. 6);

my $ref = {};

$$ref{_array}{thing} = 1;
$$ref{_array}{bling} = 2;
$$ref{_array}{blink} = 2;

print Dumper($ref);

@{$$ref{_array} }{qw(think bling blink)} = @array;

@$ref{qw(think bling blink)} = @array;

print Dumper($ref);
