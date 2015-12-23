#!/usr/bin/perl
# Project  Name: None
# File / Folder: life.pl
# File Language: perl
# First Created: 2005.01.13 12:22:49
# Last Modified: 2005.01.13 13:22:43

use strict;
use warnings;

my @On = (
	'2 2',
	'2 1',
	'1 1',
	'1 0',
	'0 2',
);

my $Times = shift || 10;
@On = tick(@On) while $Times--;

$" = ',';
print "@On\n";

sub tick {
	my %Check;
	foreach(@_) {
		$Check{$_} = 1;
		my($x, $y) = split;
		foreach my $dx (-1,0,1) {
			foreach my $dy (-1,0,1) {
				$Check{($x+$dx) . ' ' . ($y+$dy)} += 0;
			}
		}
	}

	my @New_On;
	foreach(keys %Check) {
		my($x, $y) = split;
		my $Sum = scalar grep { $Check{$_} } surrounding($x, $y);
		push @New_On, $_ if($Sum == 3 || ($Sum == 2 && $Check{$_}) );
	}

	@New_On;
}

sub surrounding {
	my($x, $y) = @_;
	my @Surrounding;
	foreach my $dx (-1,0,1) {
		foreach my $dy (-1,0,1) {
			push(@Surrounding, ($x+$dx) . ' ' . ($y+$dy) ) if($dx || $dy);
		}
	}
	@Surrounding;
}
