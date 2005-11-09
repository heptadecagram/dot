#!/usr/bin/perl
# Project  Name: None
# File / Folder: differ.pl
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.03.16 14:48:20
# Last Modifier: Liam Bryan
# Last Modified: 2005.11.09 15:45:25

use strict;
use warnings;

my @Exclude = qw(differ.pl logs);

my($Directory, $Other) = @ARGV;
die "Usage: $0 [Directory] [Other Directory]" if(@ARGV < 2);

sub GetAllFiles {
	my($Path) = @_;
	my $Directory;
	my @File_List;

	opendir $Directory, "$Path" or warn "Unable to open $Path: $!";
	foreach my $File (sort readdir $Directory) {
		next if(index($File, '.') == 0 || grep { $File =~ /$_/ } @Exclude);
		if(-d "$Path/$File") {
			push @File_List, GetAllFiles("$Path/$File");
		}
		else {
			push @File_List, "$Path/$File";
		}
	}
	closedir $Directory;

	return @File_List;
}

my @Files = GetAllFiles($Directory);

my $md5 = 'md5';
eval {
	$md5 = 'md5sum' if(system "$md5 $0 2>/dev/null");
};

my @Missing = grep {
	!-e "$Other/$_";
} @Files;

my @Different = grep {
	if(-e "$Other/$_") {
		my $This = `$md5 $_`;
		my $That = `$md5 $Other/$_`;
		$This =~ s/$_//;
		$That =~ s/$Other\/$_//;
		$This ne $That;
	}
	else {
		0;
	}
} @Files;

$, = "\n";
print( ($ARGV[2] ? @Missing : @Different), "\n");

