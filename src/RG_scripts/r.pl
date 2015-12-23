#!/usr/bin/perl

use strict;
use warnings;

foreach(0..26) {
	print "$_ : " . chr(ord('a') + $_) . " : " . sprintf('%x', ord('a')+$_) ."\n";
}
