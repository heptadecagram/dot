#!/usr/bin/perl
# Project  Name: None
# File / Folder: mail.pl
# File Language: perl
# First Created: 2007.06.07 09:43:49
# Last Modified: 2007.06.07 09:45:55

use strict;
use warnings;

use Net::SMTP;

my $smtp = Net::SMTP->new('mail.richard-group.com');

$smtp->mail($ENV{USER});
$smtp->to('liam@richard-group.com');

$smtp->data();
$smtp->datasend("To: liam\@richard-group.com\n\n");
$smtp->datasend("Hi!\n\n");
$smtp->dataend();

$smtp->quit();
