#!/usr/bin/perl
# Project  Name: None
# File / Folder: eval.pl
# File Language: perl
# First Created: 2005.01.04 13:06:20
# Last Modified: 2005.02.14 12:04:56

use strict;
use warnings;

eval {
	warn "Holy crap!";
};
if($@) {
	print "Problem: $@\n";
}
