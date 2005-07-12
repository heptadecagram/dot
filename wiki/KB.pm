#!/usr/bin/perl
# Project  Name: KB
# File / Folder: KB.pm
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.07.12 13:42:22
# Last Modifier: Liam Bryan
# Last Modified: 2005.07.12 15:48:52
package KB;

use strict;
use warnings;

use Apache::Const -compile => qw(OK HTTP_NOT_FOUND DONE);

use DBI;
use HTML::Template;

my $dbh;
BEGIN {
	$dbh = DBI->connect('DBI:Pg:dbname=kb;', 'kb', 'kb')
		or die 'Cannot connect to knowledge base';
}

END {
	$dbh->disconnect;
}


sub handler {
	my $r = shift;

	my $Request = $r->uri;
	$Request =~ s#^/##;
	$Request =~ s#/$##;

	if($Request =~ /^Special:/) {
		$r->content_type('text/html');
		$r->print('Not built yet!');
		return Apache::DONE;
	}
	unless(length $Request) {
		$r->content_type('text/html');
		$r->print("Not built $Request yet!");
		return Apache::DONE;
	}

	my $page = HTML::Template->new(filename => 'content.html');
	$page->param(
		title => $Request,
		title_uri => URIEncode($Request),
	);

	my($text, $changed_on) = $dbh->selectrow_array(q{
		SELECT text, changed_on
		FROM page
		WHERE title = ?
		ORDER BY changed_on DESC
		LIMIT 1
		}, undef,
		URIDecode($Request),
	);

	if($text) {
		$page->param(
			content => $text,
			changed_on => $changed_on,
		);
	}
	else {
		$page->param(
			content => 'This page cannot be found',
			changed_on => 'never',
		);
	}

	$r->content_type('text/html');
	$r->print($page->output);
	return Apache::DONE;
}

sub URIDecode {
	local $_ = shift;
	1 while(s/%(\d\d)/chr hex $1/e);
	tr/_/ /;
	$_;
}

sub URIEncode {
	local $_ = shift;
	tr/ /_/;
	1 while(s/[^\w\d_.-]/sprintf('%%%02X', $1)/e);
	$_;
}

1;
