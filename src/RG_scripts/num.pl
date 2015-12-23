#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use Benchmark 'cmpthese';

my @number = qw(
7453
74.53
.53
912437432178743218
9124.37432178743218
.912437432178743218
912437432178743.218
9.12437432178743218
-9.124374321787432
124.
124.0
124.00000000

-9.124-374
-9.124.374
9.124.374
.124.374
124.374.
12345678901234567890123
-
poop
-.
);

my $precision = 4;
my $length = 20;
my %correctt;
my %corrects;

cmpthese(-1,
	{
		nonre => sub {
			foreach(@number) {
				next if(tr/0-9.-//c);
				next unless(tr/0-9//);
				next if(tr/.// > 1 || tr/-// > 1);
				next if(tr/-// && substr($_, 0) ne '-');
				next if(tr/0-9// > $length);
				next if(tr/.// && length(substr($_, index($_, '.') + 1) ) > $precision);

				++$correctt{$_};
			}
		},
		regex => sub {
			foreach(@number) {
				next unless(tr/0-9//);
				next unless(/^(-?)(\d*)(\.\d*)?$/);
				next if(length $2.($3||'') > $length+1);
				next if($3 && length $3 > $precision+1);

				++$corrects{$_};
			}
		},
	}
);


print Dumper(\%correctt);
print Dumper(\%corrects);
