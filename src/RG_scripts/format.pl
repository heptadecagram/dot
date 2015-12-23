#!/usr/bin/perl
# Project  Name: None
# File / Folder: format.pl
# File Language: perl
# First Created: 2005.11.18 15:15:41
# Last Modified: 2007.04.17 15:00:11

use strict;
use warnings;

my($name, $id, $length) = qw(liam 28 229.88);
my $poop = 8;

my $output;
open STDOU, '>', \$output;
my $old_fh = select(STDOU);

format STDOU_TOP =
   Dem are bugses @<<<<
	                $poop,
.

format STDOU =
@<<<<< @|||||||| @>>>>>>>>>>>>>>>>
$name, $id,      $length,
.

$~ = 'STDOU';
$^ = 'STDOU_TOP';

write;
($name, $id, $length) = qw(goop 39 3.14);
write;
write;
$poop=10;
write;

select($old_fh);

print $output;
