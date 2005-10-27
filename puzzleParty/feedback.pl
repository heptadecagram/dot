#!/usr/bin/perl
# Project  Name: None
# File / Folder: questions.pl
# File Language: perl
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.05.07 16:33:53
# Last Modifier: Liam Bryan
# Last Modified: 2005.08.05 14:10:09


use strict;
use warnings;

use PDF::Create;


my $pdf = new PDF::Create(
	filename => 'feedback.pdf',
	Author => 'Liam Bryan',
	Title => "Feedback Form",
);
my $root = $pdf->new_page(MediaBox => [ 0, 0, 612, 792 ]);

# 792, 594, 396, 198
# 612, 459, 306, 153

# Add a page which inherits its attributes from $root
my $page = $root->new_page;
my $Question_Number = 1;

# Prepare 2 fonts
my $Helvetica = $pdf->font(BaseFont => 'Helvetica');
my $Helvetica_Bold = $pdf->font(BaseFont => 'Helvetica-Bold');
my $Times = $pdf->font(BaseFont => 'Times-Roman');
my $Times_Bold = $pdf->font(BaseFont => 'Times-Bold');
# Courier, Courier-Bold, Courier-BoldOblique, Courier-Oblique, Helvetica,
# Helvetica-Bold, Helvetica-BoldOblique, Helvetica-Oblique, Times-Roman,
# Times-Bold, Times-Italic, Times-BoldItalic

$pdf->new_outline(Title => 'Feedback');
$page->stringc($Times_Bold, 18, 306, 760, 'Feedback');
	$page->stringr($Times, 8, 48, 760, 'Name:');
	$page->line(50, 760, 150, 760);
	$page->stringr($Times, 8, 498, 760, 'Team:');
	$page->line(500, 760, 600, 760);

$page->blockl($Times, 12, 40, 744, 550, << 'EOF'
Since we want to do this again at some point, we'd like your feedback as to what puzzles you enjoyed and about how long you spent on them.  For each puzzle, please indicate how hard you found that particular puzzle, how much you enjoyed it, and how much time you personally spent on it.  If you didn't work on a problem, leave the question blank.  Also, if you have any general commentary or requests, please write it on the back of this sheet.  Thanks for participating!
EOF
);

my @questions = (
	'MMoovviieess',
	'Primeum Minutes',
	'Unsettled',
	'Delicious N-Gony',
	'Leggo my Eggsact Duplicate',
	'Acronystic',
	'Pyramid Power',
	'Coloring Between the Lines',
	'Seeing is Describing',
	'Penny Wise, Path Foolish',
	'Solve This',
	'Stacked',
	'Pop Quiz',
	'You Want Candy',
);
my $offset = 640;

	$page->stringc($Times_Bold, 12, 323, 660, 'Difficulty');
	$page->stringc($Times_Bold, 12, 423, 660, 'Fun');
	$page->stringc($Times_Bold, 12, 550, 660, 'Time');

foreach(@questions) {
	$page->stringl($Times, 12, 40, $offset, "$Question_Number. $_");

	$page->stringl($Times, 12, 300, $offset, '1 2 3 4 5');
	$page->stringl($Times, 12, 400, $offset, '1 2 3 4 5');
	$page->line(500, $offset, 600, $offset);

	$offset -= 40;
	++$Question_Number;
}



$pdf->close;
