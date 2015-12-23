#!/usr/bin/perl
# Project  Name: None
# File / Folder: r.pl
# File Language: perl
# First Created: 2005.01.20 14:37:29
# Last Modified: 2005.01.20 14:39:01

use strict;
use warnings;

foreach(0..26) {
	print "$_ : " . chr(ord('a') + $_) . " : " . sprintf('%x', ord('a')+$_) ."\n";
}
