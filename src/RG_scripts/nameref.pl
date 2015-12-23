#!/usr/bin/perl
# Project  Name: None
# File / Folder: nameref.pl
# File Language: perl
# First Created: 2006.01.27 08:06:36
# Last Modified: 2006.01.27 08:09:55

use strict;
use warnings;

my $name = 'mook';


my $ho = hork->new;

print $ho->$name;

exit;


package bloorg;

sub new {
	bless {
		_id => 5,
		_name => 7,
	}, $_[0];
}

sub id {
	my $self = shift;
	$$self{_id};
}
sub name {
	my $self = shift;
	$$self{_name};
}

package hork;

sub new {
	bless {
		_id => 2,
		_name => 3,
		_mook => bloorg->new,
	}, $_[0];
}

sub mook {
	my $self = shift;
	$$self{_mook};
}
