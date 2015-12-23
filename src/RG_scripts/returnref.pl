#!/usr/bin/perl
# Project  Name: None
# File / Folder: returnref.pl
# File Language: perl
# First Created: 2006.11.20 07:25:18
# Last Modified: 2006.11.20 07:41:06

use strict;
use warnings;

use Benchmark 'cmpthese';

sub aref {
	[1 .. $_[0] ]
}
sub aval {
	(1 .. $_[0])
}

my @result;
my $result;

my $assigner;

cmpthese(-1,
	{
		ref5 => sub { $result = aref(5); $assigner = $_ foreach(@$result); },
		val5 => sub { @result = aval(5); $assigner = $_ foreach(@result); },
		iref5 => sub { $result = aref(5); $assigner = $$result[4]; },
		ival5 => sub { @result = aval(5); $assigner = $result[4]; },
		fval5 => sub { $assigner = $_ foreach(aval(5)); },
		fref5 => sub { $assigner = $_ foreach(@{aref(5)}); },
		ref10 => sub { $result = aref(10); $assigner = $_ foreach(@$result); },
		val10 => sub { @result = aval(10); $assigner = $_ foreach(@result); },
		iref10 => sub { $result = aref(10); $assigner = $$result[9]; },
		ival10 => sub { @result = aval(10); $assigner = $result[9]; },
		fval10 => sub { $assigner = $_ foreach(aval(10)); },
		fref10 => sub { $assigner = $_ foreach(@{aref(10)}); },
		ref100 => sub { $result = aref(100); $assigner = $_ foreach(@$result); },
		val100 => sub { @result = aval(100); $assigner = $_ foreach(@result); },
		iref100 => sub { $result = aref(100); $assigner = $$result[99]; },
		ival100 => sub { @result = aval(100); $assigner = $result[99]; },
		fval100 => sub { $assigner = $_ foreach(aval(100)); },
		fref100 => sub { $assigner = $_ foreach(@{aref(100)}); },
		ref1000 => sub { $result = aref(1000); $assigner = $_ foreach(@$result); },
		val1000 => sub { @result = aval(1000); $assigner = $_ foreach(@result); },
		iref1000 => sub { $result = aref(1000); $assigner = $$result[999]; },
		ival1000 => sub { @result = aval(1000); $assigner = $result[999]; },
		fval1000 => sub { $assigner = $_ foreach(aval(1000)); },
		fref1000 => sub { $assigner = $_ foreach(@{aref(1000)}); },
	},
);
