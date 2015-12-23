#!/usr/bin/perl

use strict;
use warnings;

print $ARGV[0] =~ /^[-\w!#$%&'*+\/=?^{|}~](?:\.?[-\w!#$%&'*+\/=?^{|}~])*@[a-z](?:-?[a-z\d])*(?:\.[a-z](?:-?[a-z\d])*)+$/i;
