#!/usr/bin/perl

use strict;
use warnings;

use Benchmark qw(cmpthese);

my $string;

foreach(sort keys %ENV) {
	print "$_ => $ENV{$_}\n";
}

print "\$0 => $0\n";

exit;
cmpthese(-1,
	{
		one => sub { $string = 'supercalifragilisticexpialidocious'; },
		two => sub { $string = "supercalifragilisticexpialidocious"; },
		thr => sub { $string = q(supercalifragilisticexpialidocious); },
	}
);
