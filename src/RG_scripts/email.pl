#!/usr/bin/perl
# Project  Name: None
# File / Folder: email.pl
# File Language: perl
# First Created: 2007.02.20 07:31:16
# Last Modified: 2007.02.20 07:44:04

use strict;
use warnings;

print $ARGV[0] =~ /^[-\w!#$%&'*+\/=?^{|}~](?:\.?[-\w!#$%&'*+\/=?^{|}~])*@[a-z](?:-?[a-z\d])*(?:\.[a-z](?:-?[a-z\d])*)+$/i;
