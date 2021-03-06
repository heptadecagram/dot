#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $a = ME->new;
my $b = ME->new;
my $c = ME->new;

my %hash = (
	1 => ['a' .. 'g'],
	2 => {
		one => $a,
		two => $b,
		three => $c,
	},
	3 => 'c',
);

my @baak = @{ $hash{1} };

$hash{2}{one}{_k} = 3;

my @o = values %{$hash{2} };

push @{$hash{1} }, ME->new;

$_->do foreach(@o);

push @o, ME->new;


$baak[2] = 'MAM';

print Dumper(%hash);

package ME;

sub new {
	bless {}, shift;
}

sub do {
	my $self = shift;

	$$self{_g} = 1;
}
