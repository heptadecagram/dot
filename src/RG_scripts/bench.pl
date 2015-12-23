#!/usr/bin/perl
# Project  Name: RG_ECOMMERCE
# File / Folder: bench.pl
# File Language: perl
# First Created: 2005.02.14 15:35:58
# Last Modified: 2005.04.19 09:29:08

use strict;
use warnings;

use Settings;

use Benchmark 'cmpthese';

$SITE{site} = 'ss';

my $offset = 100;
my $length = 10;

my @array;

cmpthese(-1,
	{
		two => sub {
			my($size) = $dbh->selectrow_array(q{
				SELECT COUNT(*) FROM item
				}
			);
			my $results = $dbh->prepare(qq{
				SELECT * FROM item
				LIMIT $length OFFSET $offset
				}
			);
			$results->execute;
			while(my @results  = $results->fetchrow_array) {
				@array = @results;
			}

		},
		one => sub {
			my $results = $dbh->prepare(qq{
				SELECT * FROM item
				}
			);
			$results->execute;
			my $counter = 0;
			while($results->fetch) {
				last if(++$counter >= $offset);
			}
			$counter = 0;
			while(my @results = $results->fetchrow_array) {
				last if(++$counter >= $length);
				@array = @results;
			}

			my $size = $results->rows;
		},
	},
);

