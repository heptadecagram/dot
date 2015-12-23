#!/usr/bin/perl
# Project  Name: None
# File / Folder: adam.pl
# File Language: perl
# First Created: 2006.11.21 08:03:10
# Last Modified: 2006.11.21 08:06:02

use strict;
use warnings;

use Data::Dumper;
my $self = {};


$self->{OldData} = [qw(g10 f12)];
$self->{NewData} = \$$self{OldData};

print Dumper($self);

$self->{OldData} = [];
print Dumper($self);
