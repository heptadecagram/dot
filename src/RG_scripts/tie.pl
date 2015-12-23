#!/usr/bin/perl
# Project  Name: None
# File / Folder: tie.pl
# File Language: perl
# First Created: 2005.09.16 10:35:29
# Last Modified: 2005.09.16 10:47:23

use strict;
use warnings;

use Data::Dumper;

my $k = Alphonse->new;

print $$k{monkey} . "\n";
print $$k{monkey} . "\n";
print $$k{jeep} . "\n";

print Dumper($k);

package Alphonse;

sub TIEHASH {
	bless {
		one => 'eek',
		two => 'peek',
		@_[1 .. $#_],
	}, $_[0];
}

sub FETCH {
	my($self, $key) = @_;

	if($key eq 'monkey') {
		$$self{monkey} = 'What a bad monkey! ' . ++$$self{_monkey_count};
	}

	$$self{$key};
}

sub FIRSTKEY { my $a = scalar keys %{$_[0]}; each %{$_[0]} }
sub NEXTKEY  { each %{$_[0]} }

sub new {
	my $class = shift;
	$class = ref($class) || $class;

	my $self = {};

	tie %$self, 'Alphonse', jeep => 'hoo-ha!';

	bless $self, $class;
}
