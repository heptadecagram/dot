#!/usr/bin/perl
# Project  Name: None
# File / Folder: stat.pl
# File Language: perl
# First Created: 2006.01.11 10:20:56
# Last Modified: 2006.01.11 12:52:12

use strict;
use warnings;

my $TOTAL = shift || 100;
my %males;
my %females;

foreach(1 .. $TOTAL) {
	$males{$_} = [ random10() ];
	$females{$_} = [ random10() ];
}

sub random10 {
	my @return;
	while(scalar @return < int($TOTAL/10)) {
		my $random = int(rand $TOTAL) + 1;
		next if(grep { $_ == $random } @return);
		push @return, $random;
	}

	@return;
}

my @twu_love;
my @male_loners;
my @female_loners;
my $current = 0;

foreach my $male (keys %males) {
	foreach my $female (@{$males{$male} }) {
		if(grep {$_ == $male} @{$females{$female} }) {
			push @twu_love, [$male, $female];
		}
	}
	if(scalar @twu_love == $current) {
		push @male_loners, $male;
	}
	$current = scalar @twu_love;
}

foreach my $female (1 .. $TOTAL) {
	unless(grep {$female == $_} map {$$_[1]} @twu_love) {
		push @female_loners, $female;
	}
}

my %availability;

#foreach my $person (1 .. $TOTAL) {
#my $times_male = 0;
#my $times_female = 0;
#foreach(@twu_love) {
#$times_male++ if($person == $$_[0]);
#$times_female++ if($person == $$_[1]);
#}
#
#$availability{male}{$person} = $times_male;
#$availability{female}{$person} = $times_female;
#}

#foreach(sort { $availability{male}{$b} <=> $availability{male}{$a} } keys %{$availability{male} }) {
#last unless($availability{male}{$_});
	#print "Male Person $_ has $availability{male}{$_} potentials\n";
#}
#foreach(sort { $availability{female}{$b} <=> $availability{female}{$a} } keys %{$availability{female} }) {
#last unless($availability{female}{$_});
	#print "Female Person $_ has $availability{female}{$_} potentials\n";
#}

sub maximal_cover {
	my @female_sluts = sort { $availability{female}{$a} <=> $availability{female}{$b} } grep {$availability{female}{$_} } keys %{$availability{female} };
	my @male_sluts = sort { $availability{male}{$a} <=> $availability{male}{$b} } grep {$availability{male}{$_} } keys %{$availability{male} };

	foreach(@female_sluts) {
	}

}


print "Total potential couples: " . scalar(@twu_love) . "\n";
print "Loners: " . scalar(@male_loners) . " male, " . scalar(@female_loners) . " female\n";
