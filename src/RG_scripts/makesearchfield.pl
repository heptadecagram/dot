#!/usr/bin/perl

use strict;
use warnings;

use DBI;

use Settings;

$SITE{site} = 'ss';

my $table_tag = 'designers';
my @fields = qw(name body);

my $dbh = $SITE{cdb};

my $table = "$SITE{site}_$table_tag";

foreach(@fields) {
	$dbh->do(qq#
		ALTER TABLE $table
		ADD COLUMN idx_$_ TXTIDX
		#
	);

	$dbh->do(qq#
		CREATE INDEX tidx_${table}_$_
		ON $table USING(idx_$_)
		#
	);

	$dbh->do(qq#
		CREATE TRIGGER tidxupd_${table}_$_
		BEFORE UPDATE OR INSERT ON $table
		FOR EACH ROW EXECUTE PROCEDURE tsearch(idx_$_, $_)
		#
	);
}

$dbh->do(qq#
	UPDATE contentfields
	SET search_field = TRUE
	WHERE fieldid IN
	(SELECT fieldid FROM contenttables
	WHERE siteid = ?
	AND tag = ?)
	#, undef,
	$SITE{siteid}, $table_tag,
);

$dbh->do(qq{
	UPDATE $table
	SET modified = modified
	}
);
