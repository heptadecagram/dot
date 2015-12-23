#!/usr/bin/perl

use strict;
use warnings;

my @things = qw(
hierarchy.questions.flatten
hierarchy.questions.5
hierarchy.questions.flatten.5
hierarchy.questions.flatten.5.3-7
hierarchy.questions.flatten.5.3-7.sort+created
hierarchy.questions.flatten.5.3-7.sort-modified
hierarchy.questions.sort-modified
hierarchy.questions.5.3-7.sort-modified
hierarchy.questions.3-7.sort-modified
hierarchy.questions.3-7
);

local $_ = '123456789';

print 'found ^1' if(/^1/);
print 'found 9$' if(/9$/);
print 'found 1|2$' if(/1|2$/);
print 'found ^1|9$' if(/^1|9$/);

exit;

foreach(@things) {
	/^hierarchy\.questions(\.flatten)?(?:\.(\d+))?(?:\.(\d+-\d+))?(?:\.sort([+-][^.]+))?$/i;
	for(1 .. 4) {
		eval qq{print "$_ is " . (defined \$$_ ? \$$_ : 'undef') . "\n";};
	}
	print "\n";
}
