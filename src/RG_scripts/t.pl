#!/usr/bin/perl
# Project  Name: None
# File / Folder: t.pl
# File Language: perl
# First Created: 2004.11.12 11:59:34
# Last Modified: 2004.11.12 14:28:56

use strict;
use warnings qw/all/;

my %A = (
	aleph => [1,2,3],
	beth => [4,5,6],
	#$gimel => [7,8,9],
);

sub rec(\%@) {
	my %T = %{shift()};
	my @Values = @_;
	my $Key = ( (sort keys %T)[0]);
	my @Current_Values = @{$T{$Key} };
	my @Return;
	print "$Key [@Current_Values] @Values\n";
	delete $T{$Key};
	if(keys %T) {
		foreach(@Current_Values) {
			push @Return, &rec(\%T, $_, @Values);
		}
	}
	else {
		foreach(@Current_Values) {
			local $" = '-';
			push @Return, "-$_-@Values-";
		}
	}
	@Return;
}

my %V;
foreach(rec(%A) ) {
	tr/-//s;
	$V{$_} = 1;
}

sub mv : lvalue {
	$V{$_[0]};
}

my @C = ( 3,4,5);
unshift @C, 1, 2;
print "@C";
#exit;
my $undef = undef;

foreach(keys %V) {
	print "$_ : " . mv($_) . "\n";
	my @each = split '-';
	foreach(@each) {
		print "----'$_'\n" if($_);
	}
	mv($_) = $undef;
	print "$_ : " . mv($_) . "\n";
	print "\n";
}
