#!/usr/bin/perl

use strict;
use warnings;

# 3200 x 2500:
# liam:~/Test_Space/ time perl man.pl > mndl
#
# real    104m51.928s
# user    83m27.180s
# sys     0m21.320s

my $X = 3200;
my $Y = 2500;
my $ITER = 200;

my @Colors = (
	[ 128,   0,   0, ],
	[ 255,   0,   0, ],
	[   0, 128,   0, ],
	[   0, 255,   0, ],
	[   0,   0, 128, ],
	[   0,   0, 255, ],
	[   0, 128, 128, ],
	[   0, 255, 128, ],
	[   0, 128, 255, ],
	[   0, 255, 255, ],
	[ 128,   0, 128, ],
	[ 255,   0, 128, ],
	[ 128,   0, 255, ],
	[ 255,   0, 255, ],
	[ 128, 128,   0, ],
	[ 255, 128,   0, ],
	[ 128, 255,   0, ],
	[ 255, 255,   0, ],
);


sub norm {
	sqrt($_[0][0]*$_[0][0] + $_[0][1]*$_[0][1]);
}

sub L {
	[
	$_[1][0] + $_[0][0]*$_[0][0] - $_[0][1]*$_[0][1],
	$_[1][1] + 2*$_[0][0]*$_[0][1],
	];
}

my($x, $y);

foreach $x (0..$X) {
	foreach $y (0..$Y) {
		my $n;
		my $z = [0,0];
		my $c = [$x*3.2/$X - 2.1, 1.25 - $y*2.5/$Y];
		for($n = 0; $n<$ITER && norm($z)<2; ++$n) {
			$z = L($z, $c);
		}
		if($n<$ITER) {
			#my $Level = 63*int(4*$n/$ITER);
			#unless(exists $Colors{$n}) {
			#$Colors{$n} = $Image->colorAllocate(@{$Colors[rand $#Colors]});
			#}
			print "$x $y $n\n";
			#$Image->setPixel($x, $y, $Colors{$n});
		}
	}
}

