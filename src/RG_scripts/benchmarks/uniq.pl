#!/usr/bin/perl


use strict;
use warnings;


use Data::Dumper;
use Benchmark 'cmpthese';

my @A = (1, 2, 3, 4, 5, 6, 7, 8, 9,);
my @B = (1,    3,    5,    7,    9,);
my @C = (   2,    4,    6,    8, 9,);

sub un1 {
	my%u;grep{!$u{$_}++?1:0}@_;
}

sub un2 {
	my%u;@u{@_}=1;keys%u;
}

sub un3 {
	keys%{{map{$_,1}@_}};
}

cmpthese(-1,
	{
		un1 => 'un1(@A, @B, @C, (1..9))',
		un2 => 'un2(@A, @B, @C, (1..9))',
		un3 => 'un3(@A, @B, @C, (1..9))',
	}
);

print Dumper(un1(@A, @C) );
print "\n";
