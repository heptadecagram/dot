#!/usr/bin/perl
# Project  Name: None
# File / Folder: ref.pl
# File Language: perl
# First Created: 2005.01.17 09:26:36
# Last Modified: 2006.11.20 07:24:07

use strict;
use warnings;

use Benchmark 'cmpthese';

my $Reference = [ 0, 1, 2, 3, 4, 5, 6, ];
my $result;

cmpthese(-1,
	{
		arrow => sub { $result = $Reference->[$_] for(0 .. @$Reference-1); },
		dollr => sub { $result = $$Reference[$_] for(0 .. @$Reference-1); },
	},
);
