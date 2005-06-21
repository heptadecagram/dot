#!/usr/bin/perl
# Project  Name: None
# File / Folder: Page.pm
# File Language: perl
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.06.16 19:47:34
# Last Modifier: Liam Bryan
# Last Modified: 2005.06.20 22:07:24
package Page;

use strict;
use warnings;

sub new {
	my $class = shift;
	$class = ref($class) if(ref $class);

	bless {
		text => '',
	}, $class;
}

sub parse {
	my $self = shift;

	local $_ = $$self{_text};

	# Convert lone ampersands.
	s/&(?!:amp;|\w{2,6};|#\d{2,4};|#x[\da-f]{2,4};)/&amp;/gi;

	# ^^2^^ to <small><sup>2</sup></small>
	s#\^\^(.*?)\^\^#<small><sup>$1</sup></small>#g;

	# '''bold''' to <b>bold</b>
	s#'''(.*?)'''#<b>$1</b>#g;

	# ''italics'' to <i>italics</i>
	s#''(.*?)''#<i>$1</i>#g;

	# [[link|text]] to <a href="link">text</a>
	s#\[\[(.*?)(?:\|(.*?))?\]\]#'<a href="'.encode($1).'">'.($2 || $1).'</a>'#ge;

	# ==Title== to <h1>Title</h1>
	s#=(=+)(.*?)=\1\n*#'<h'.length($1).">$2</h".length($1).">\n\n"#ges;

	# --- to <hr/>
	s#^---*#<hr/>#g;

	#  code to <pre> code</pre>
	s#((?:^[ \t]+\S[^\n]*\n)+)\n*#<pre>\n$1</pre>\n\n#gms;

	# text to <p>text</p>
	s#((?:^(?!\s|<h|</?pre).+?)+)(?:\n{2,}|\Z)#<p>$1</p>\n\n#gms;

	s"^[*#](.*?)\n"<li>$1</li>\n"g;
	#s#\*#<ul><li></li>#g;
	#s"#"<ol><li></li>"g;
	#s":dt;dd"<dl><dt></dt><dd></dd>"g;

	$_;
}

sub raw {
	my $self = shift;

	$$self{_text};
}

sub encode {
	local $_ = shift;

	tr/ /_/;

	$_;
}

1;
