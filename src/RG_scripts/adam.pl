#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
my $self = {};


$self->{OldData} = [qw(g10 f12)];
$self->{NewData} = \$$self{OldData};

print Dumper($self);

$self->{OldData} = [];
print Dumper($self);
