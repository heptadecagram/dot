#!/usr/bin/perl


use strict;
use warnings;

use Benchmark 'cmpthese';

my @things;
$things[$_] = 2*$_ foreach(0 .. 100);

sub arr { map { $_/2.0} @things }
sub rff { [map { $_/2.0} @things] }
sub wan { my@x=map{$_/2.0}@things;wantarray?@x:\@x; }
cmpthese(-1,
	{
		arr => sub { my$x;foreach(arr()){$x=$_/2.0} },
		rff => sub { my$x;foreach(@{rff()}){$x=$_/2.0} },
		waa => sub { my$x;foreach(wan()){$x=$_/2.0} },
		war => sub { my$x;foreach(@{wan()}){$x=$_/2.0} },
	}
);
