#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my $string = 'RanDomStringY!$WheeeeE';
my $result;

cmpthese(-1,
	{
		low => sub { local $_ = $string; $result = lc; },
		trs => sub { local $_ = $string; tr/A-Z/a-z/; $result = $_; },
	}
);

my $name = 'ooUUUoo';
#print qq{ I am a pretty \UeLiTeSpEaKeR\E, my name is \L$name\E\n};
#print  q{ I am a pretty \UeLiTeSpEaKeR\E, my name is \L$name\E\n};
