#!/usr/bin/perl
# Project  Name: None
# File / Folder: Page.pm
# File Language: perl
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.06.16 19:47:34
# Last Modifier: Liam Bryan
# Last Modified: 2005.07.12 11:51:14
package Page;

use strict;
use warnings;

my $dbh;

sub new {
	my $class = shift;
	$class = ref($class) if(ref $class);
	my %params = @_;
	my $self = {};

	if($params{id}) {
	}
	elsif($params{name}) {
		@$self{qw(_id _name _text)} = $dbh->selectrow_array(q{
			}, undef,
			$params{name},
		);
	}
	elsif($params{text}) {
		$$self{_text} = $params{text};
	}

	bless $self, $class;
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
	s#^=(=+)(.*?)=\1\n*#'<h'.length($1).">$2</h".length($1).">\n\n"#gems;

	# --- to <hr/>
	s#^---*#<hr/>#gm;

	#  code to <pre> code</pre>
	s#((?:^[ \t]+\S[^\n]*\n)+)\n*#<pre>\n$1</pre>\n\n#gms;

	# # or * to <ol><li> or <ul><li>
	# TODO Not quite working correctly on nested lists, yet.
	if(s{^([#*]*)([#*])(.*?)\n}
		{$1 . ($2 eq '*' ? '<ul>' : '<ol>') . "<li>$3</li>" . ($2 eq '*' ? '</ul>' : '</ol>') . "\n"}egm) {
		$_ = reverse;
		s"(\n[^\n]+)(>l([ou])<[*#]*)\n>l\3/<(?=[^\n]+\2)"$1\n"gms;
		$_ = reverse;
		s"(</li></[ou]l>)\n[*#]*(<(o|u)l>.*?</\3l>)"\n$2\n$1"gs;
		s"</(o|u)l>\n<\1l>"\n"g;
	}

	#s";term:definition"<dl><dt>term</dt><dd>definition</dd></dl>"g;

	#s#~~~#[[Name]]#g;

	# text to <p>text</p>
	s#((?:^(?!\s|</?ol|</?ul|</?li|<h|</?pre).+?)+)(?:\n{2,}|\Z)#<p>$1</p>\n\n#gms;
	s#<p>(:+)#'<p style="text-indent: ' . (2 * length $1) . 'em">'#gmse;

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
