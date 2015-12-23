#!/usr/bin/perl
# Project  Name: None
# File / Folder: rand.pl
# File Language: perl
# First Created: 2004.11.29 15:27:34
# Last Modified: 2005.08.19 12:41:27

use strict;
use warnings;

my @array = (1 .. 4);
my %Heur;


sub shuffle {
	my $a = $_ + rand(@_ - $_) and @_[$_, $a] = @_[$a, $_] for(0 .. $#_);
	@_;
}

for(1 .. 100_000) {
	#my @shuffled = map{$_->[0]} sort{$a->[1]<=>$b->[1]} map{[$_, rand(1)]} @array;
	my @shuffled = sort { rand 1 <=> .5 } @array;
	++$Heur{"@shuffled"};
}

foreach(sort {$Heur{$a} <=> $Heur{$b}} keys %Heur) {
	print "$_ : $Heur{$_}\n";
}
