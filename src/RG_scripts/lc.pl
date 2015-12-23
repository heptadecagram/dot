#!/usr/bin/perl
# Project  Name: None
# File / Folder: lc.pl
# File Language: perl
# First Created: 2004.12.29 14:50:31
# Last Modified: 2006.11.21 10:33:31

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
