#!/usr/bin/perl

use strict;
use warnings;

eval {
	warn "Holy crap!";
};
if($@) {
	print "Problem: $@\n";
}
