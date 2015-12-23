#!/usr/bin/perl
# Project  Name: None
# File / Folder: n.pl
# File Language: perl
# First Created: 2004.12.28 12:25:29
# Last Modified: 2005.08.18 15:09:07

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
