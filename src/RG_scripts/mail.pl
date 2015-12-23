#!/usr/bin/perl

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
