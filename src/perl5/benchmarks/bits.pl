#!/usr/bin/perl

use strict;
use warnings;

use Benchmark 'cmpthese';

my @numbers = map { rand(4294967296) } (1..100);

sub st {
	sprintf('%b',$_[0])=~y/1//;
}
sub ke {
	my $v = shift;
	my $c = 0;
	for(;$v;++$c) {
		$v &= $v - 1;
	}
	$c;
}

print st($numbers[0]);
print ke($numbers[0]);
print st($numbers[1]);
print ke($numbers[1]);
__END__


my $ret;
cmpthese(-1,
	{
		kern => sub { $ret = ke($_) foreach(@numbers) },
		str  => sub { $ret = st($_) foreach(@numbers) },
	}
);
