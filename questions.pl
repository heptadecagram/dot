#!/usr/bin/perl
# Project  Name: None
# File / Folder: questions.pl
# File Language: perl
# Copyright (C): 2005 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2005.05.07 16:33:53
# Last Modifier: Liam Bryan
# Last Modified: 2005.08.04 21:35:54


use strict;
use warnings;

use Data::Dumper;
use PDF::Create;

sub box {
	my $page = shift;
	$page->line(@_[0,1,0,3]);
	$page->line(@_[0,3,2,3]);
	$page->line(@_[2,3,2,1]);
	$page->line(@_[2,1,0,1]);
}

sub longline {
	my $page = shift;

	my $start = shift;
	my $current = $start;
	while(my $next = shift) {
		$page->line(@$current, @$next);
		$current = $next;
	}
}
sub linkline {
	my $page = shift;

	my $start = shift;
	my $current = $start;
	while(my $next = shift) {
		$page->line(@$current, @$next);
		$current = $next;
	}
	$page->line(@$current, @$start);
}

sub hvlth {
	my $page = shift;

	my $starting = 396 - length($_[0])*7;

	my $position = 0;
	foreach(letter_convert(split //, $_[0]) ) {
		$$_[1] += $starting + $position foreach(@$_);
		longline($page, @$_);
		$position += 14;
	}
}

sub letter_convert {
	my %letter = (
		' ' => [],

		y => [qw(1 2 3 1)],
		S => [qw(0 2 3 0)],
		T => [qw(1 0 3 1)],
		C => [qw(1 2 0 1)],

		t => [qw(1 2 3 0 2)],
		p => [qw(1 2 3 1 0)],
		b => [qw(2 3 0 1 3)],
		d => [qw(0 1 2 0 3)],

		c => [qw(3 2 0 1 2)],
		f => [qw(3 1 2 3 0)],
		s => [qw(1 0 2 3 0)],
		k => [qw(1 3 0 1 2)],

		w => [qw(0 2 3 1 2)],
		v => [qw(1 3 2 0 3)],
		r => [qw(2 0 3 1 0)],
		l => [qw(3 1 3 2 1)],

		n => [qw(2 0 1 2 3 1)],
		m => [qw(3 1 2 3 0 2)],
		g => [qw(0 2 3 0 1 3)],
		h => [qw(1 3 0 1 2 0)],

		u => [qw(3 1 2 0)],
		o => [qw(1 3 2 0)],
		a => [qw(1 3 0 2)],
		i => [qw(3 1 0 2)],
		e => [qw(0 2 3 1 0)],
		E => [qw(0 2 1 3 0)],
	);

	map {
		[ map {
			if(/0/) {
				[20, 20];
			}
			elsif(/1/) {
				[10, 20];
			}
			elsif(/2/) {
				[10, 10];
			}
			elsif(/3/) {
				[20, 10];
			}
		} @{$letter{$_} } ]
	} @_;
}


my $pdf = new PDF::Create(
	filename => 'questions.pdf',
	Author => 'Liam Bryan',
	Title => "Liam & Liana's Puzzle Party",
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
sub new_puzzle {
	my $name = shift;

	$page = $root->new_page;
	$pdf->new_outline(Title => $name);
	$page->stringc($Times_Bold, 18, 306, 774, $Question_Number++.". \U$name");

	$page;
}

sub scoring {
	$page->blockl($Helvetica, 10, 40, 40, 510, "SCORE: $_[0]");
}

# Prepare a Table of Content
$pdf->new_outline(Title => 'Introduction');

$page->stringc($Times_Bold, 40, 306, 694, "Liam and Liana's Puzzle Party");
$page->stringc($Times, 20, 306, 664, "August 6th, 2005");

$page->stringl($Times, 12, 25, 604, << 'EOF'
By now, you have found your team based on the name tag puzzle.  It is
reccommended that your team selects a name, for in the incredibly unlikely
case of a tie, the referees will decide in favor of the team with the
cooler name.  If that also fails, ties will be resolved by fisticuffs.

Your team should now be in possession of:
    * This Booklet
    * 10 pencils
    * 10 pens
    * 50 sheets of scratch paper
    * 10 sheets of graph paper
    * 1 calculator
    * 5 brains, with containers
    * 1 bag of plastic struts and white nodes
    * 2 plastic structures as examples
    * 1 deck of Set
    * some candy
    * 16 standard playing cards

Replacements for some of these materials are available from the referee
station.  Due to the nature of these puzzles, any other materials, such
as cell phones, dictionaries, or PDAs are prohibited.  The referees will
not rule on whether answers (such as words, titles, numbers) are valid
until they are submitted.  For words, we shall be using some combination
of dictionary.com and answers.com to determine if an answer is an English
word.  No proper nouns, please.

When your team decides to score a puzzle, bring it to the referee station,
and give it to a referee.  Once you give a puzzle to a referee, you may not
re-submit that puzzle again, even if you come up with a better
solution.  However, teams that submit puzzle solutions sooner
are rewarded thusly:

	1st team: 100% of points scored for the puzzle
	2nd team:  90%
	3rd team:  85%
	4th team:  75%

If two teams submit solutions to the same puzzle within five minutes of each
other, it will be considered a tie and they will both have the higher
percentage applied to that puzzle's score.

The contest begins at 1:00PM, and run until 5:00PM.  Around 4:00PM,
the referees will make sure that everyone who wishes to place an order
to the takeaway restaurant has done so, and food will be ordered at
4:30PM, to arrive around 5:00PM.

EOF
);


# Add another page
new_puzzle('Mmoovviieess');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
For each letter of the alphabet, write down a movie title.  Your score for this puzzle is based on the number of times the particular letter appears in the movie title.  We will use IMDB for validating movie titles.
EOF
);

$page->blockl($Helvetica, 12, 40, 700, 550, << 'EOF'
Example: Writing down "Abracadabra" for the letter A would generate 50 points (5 occurences times 10), while writing it down for the letter B would generate 20 points (2 occurrences times 10).
EOF
);
scoring('10 x N for each valid title, where N is the number of the desired letter.');
hvlth($page, 'Tis cryptogram is written in an unknown script wiT');

$page = $root->new_page;
foreach('A' .. 'Z') {
	my $line = 750 - 27 * (ord() - 64);
	$page->stringl($Times, 14, 40, $line, "$_");
	$page->line(50, $line, 570, $line);
}



# Add another page
new_puzzle('Primeum Minutes');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
Using a phone's keypad, write down an English word for each numerical length whose digit-by-digit representation is prime.  You gain points for each word of a given length if and only if you have found words for the lengths less than it. (i.e., to gain points for a five-letter-word, you must have a four-letter prime word, a three-letter prime word, and a two-letter prime word.)
EOF
);
$page->blockl($Helvetica, 12, 40, 700, 550, << 'EOF'
Example: The one-letter-word 'A' maps to 2, which is prime.  The five-letter-word 'EVERY' maps to 38379: E = 3, V = 8, E = 3, R = 7, Y = 9, which is not prime, as it has factors 3, 11, and 1163.
EOF
);
sub key {
	my $page = shift;
	my($number, $text, $X, $Y) = @_;

	box($page, $X, $Y, $X+50, $Y+50);
	$page->stringc($Times, 12, $X+25, $Y+6, $text);
	$page->stringc($Times_Bold, 18, $X+25, $Y+30, $number);
}
key($page, 1, '     ', 200, 500);
key($page, 2, 'A B C', 260, 500);
key($page, 3, 'D E F', 320, 500);
key($page, 4, 'G H I', 200, 440);
key($page, 5, 'J K L', 260, 440);
key($page, 6, 'M N O', 320, 440);
key($page, 7, 'P Q R S', 200, 380);
key($page, 8, 'T U V', 260, 380);
key($page, 9, 'W X Y Z', 320, 380);

foreach(2 .. 8) {
	my $line = 320 - 27 * $_;
	$page->stringr($Times, 14, 80, $line, $_);
	$page->line(85, $line, 290, $line);
	$page->stringr($Times, 14, 380, $line, $_+6);
	$page->line(385, $line, 590, $line);
}

scoring('200 x L, where L is the length of the longest prime word you find.  You must find all prime words of length less than L.');
hvlth($page, 'many strangE properties  first is Tat Tis script is');


# Add another page
new_puzzle('Unsettled');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
You have a deck of the game Set.  Sort the entire deck into piles of cards.  Each pile must not contain a 'set' by the game's definition of 'set'.  Your score is determined by having as few of these piles as possible.

EOF
);
scoring('4000 / ( N - 5), where N are the number of piles that you have.');
hvlth($page, 'written from bottom to top  second is Tat most');


# Add another page
new_puzzle('Delicios N-gony');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
For each regular polygon of P sides, write down the number of sections that it has when all of its vertices are fully connected (i.e., each vertex has a line between it and every other vertex).  You will receive points for each polygon, up to a seventeen-sided polygon (heptadecagram).
EOF
);

$page->blockl($Helvetica, 12, 40, 710, 550, << 'EOF'
Example: When a five-sided polygon has all of its vertices connected, there are 11 sections.
EOF
);

sub pentagon {
	my($page, $x, $y) = @_;
	linkline($page,
		[100+$x,$y],
		[25*(sqrt(5)-1)+$x, 25*sqrt(10+2*sqrt(5))+$y],
		[-25*(sqrt(5)+1)+$x, 25*sqrt(10-2*sqrt(5))+$y],
		[-25*(sqrt(5)+1)+$x, -25*sqrt(10-2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, -25*sqrt(10+2*sqrt(5))+$y],
	);
}
pentagon($page, 200, 600);

{
	my($x, $y) = (400, 600);
	pentagon($page, $x, $y);
	linkline($page,
		[100+$x,$y],
		[-25*(sqrt(5)+1)+$x, 25*sqrt(10-2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, -25*sqrt(10+2*sqrt(5))+$y],
	);
}

{
	my($x, $y) = (200, 400);
	pentagon($page, $x, $y);
	linkline($page,
		[100+$x,$y],
		[-25*(sqrt(5)+1)+$x, 25*sqrt(10-2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, -25*sqrt(10+2*sqrt(5))+$y],
		[-25*(sqrt(5)+1)+$x, -25*sqrt(10-2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, 25*sqrt(10+2*sqrt(5))+$y],
		[-25*(sqrt(5)+1)+$x, -25*sqrt(10-2*sqrt(5))+$y],
	);
}
{
	my($x, $y) = (400, 400);
	pentagon($page, $x, $y);
	linkline($page,
		[100+$x,$y],
		[-25*(sqrt(5)+1)+$x, 25*sqrt(10-2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, -25*sqrt(10+2*sqrt(5))+$y],
		[25*(sqrt(5)-1)+$x, 25*sqrt(10+2*sqrt(5))+$y],
		[-25*(sqrt(5)+1)+$x, -25*sqrt(10-2*sqrt(5))+$y],
	);
}
$page->stringc($Times, 17, 380, 450, 1);
$page->stringc($Times, 17, 420, 440, 2);
$page->stringc($Times, 17, 450, 430, 3);
$page->stringc($Times, 17, 360, 420, 4);
$page->stringc($Times, 17, 400, 400, 5);
$page->stringc($Times, 17, 440, 390, 6);
$page->stringc($Times, 17, 340, 390, 7);
$page->stringc($Times, 17, 360, 370, 8);
$page->stringc($Times, 17, 380, 340, 9);
$page->stringc($Times, 17, 420, 350, 10);
$page->stringc($Times, 17, 450, 350, 11);

foreach(6 .. 11) {
	my $line = 420 - 27 * $_;
	$page->stringr($Times, 14, 130, $line, $_);
	$page->line(135, $line, 170, $line);
	$page->stringr($Times, 14, 330, $line, $_+6);
	$page->line(335, $line, 370, $line);
}

scoring('P x 20 for each and every polygon of P sides for which you find a correct answer.');
hvlth($page, 'dipTongs havE been replaced wiT a singlE Caracter');


# Add another page
new_puzzle('Leggo my Eggsact Duplicate');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
Choose two people from your team.  One will be the observer, and the other will be the builder.  When they report to the referee's station, they will sit back-to-back.  At this point, the builder will be given a number of Legos, and the observer will be given a pre-built (glued) Lego structure.  The goal is for the builder to re-create the structure that the observer has been given, but no player is allowed to look at the other's progress.  The observer may use any sort of verbal communication to guide the builder, but only verbal communication is allowed between the two players.  When you believe you are finished, notify the referee, who will check the builder's work.
EOF
);

scoring('4000 - (6 x X) - Y, where X is the number of pieces either missing or wrongly added, and Y is the sum over all pieces of the number of pips that an incorrectly placed piece is off by.');
hvlth($page, 'Te Tird strangE property is Tat onE vowel can be');


# Add another page
new_puzzle('Acronystic');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
Write down a set of acronyms that contain every letter of the alphabet.  Note that an acronym is an abbreviation that is pronounced as its own word.  Thus, RADAR (RAdio Detection And Ranging) is an acronym, as it is pronounced "ray-dar", but USA (United States of America) is pronounced "you-ess-ay", and thus is not an acronym.  You must write down both the acronym and what it stands for (or a reasonable approximation thereof).  Your goal is to come up with the smallest set of acronyms that contains all the letters in the alphabet.
EOF
);

scoring('( 4000 - ( N x 200 ) ) / ( 27 - M ), where N are the number of acronyms you have, and M are the number of distinct letters of the alphabet found.');
hvlth($page, 'represented by morE Tan onE Caracter depending');


# Add another page
new_puzzle('Pyramid Power');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
You have been given a bag of colorful plastic struts and white nodes, or vertices.  Using these nodes and struts, build tetrahedra (four-sided pyramids, with all faces being some sort of triangle).  Each pyramid you build must be attached in some way to the rest of them, so you are building a long chain of structures. No two pyramids may share more than one edge.  This also means that no two pyramids may share a face.  Additionally, you will only score for each unique pyramid.  There are over 60 unique combinations of struts and nodes that create tetrahedra.  "Scaled" versions of pyramids (that is, ones whose angles are identical, but use differently sized edges) do not count as unique.  Included is an example of three pyramids joined on only edges, and a separate pyramid which shows an example of an invalid pyramid for this example (as it is merely a larger version of one of the existing pyramids in the main example).
EOF
);

scoring('150 x N, where N is the number of distinct joined pyramids.');
hvlth($page, 'on its pronunciation  to solvE Tis problem you Sould');


# Add another page
new_puzzle('Coloring Between the Lines');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
In the grid below, write down the names of as many colors as possible.  All words must interlock; no "islands" of words are allowed.  Standard Scrabble rules apply:  If two letters are next to each other in any orthogonal direction, they must be part of a word.  A word is considered a color if part of its definition refers to it as a color.
EOF
);

foreach(0 .. 14) {
	$page->line(100, 700-30*$_, 520, 700-30*$_);
	$page->line(100+30*$_, 280, 100+30*$_, 700);
}
{
	$page->stringl($Times, 12, 120, 220, 'RIGHT:');
	my $index;
	$index=0;
	foreach(qw(A P P L E) ) {
		$page->stringc($Helvetica, 14, 200, 200-16*$index++, $_);
	}
	$index=0;
	foreach(qw(G R A P E) ) {
		$page->stringc($Helvetica, 14, 152+16*$index++, 168, $_);
	}
}
{
	$page->stringl($Times, 12, 320, 220, 'WRONG:');
	my $index;
	$index=0;
	foreach(qw(A P P L E) ) {
		$page->stringc($Helvetica, 14, 400, 200-16*$index++, $_);
	}
	$index=0;
	foreach(qw(G R A P E) ) {
		$page->stringc($Helvetica, 14, 414, 151-16*$index++, $_);
	}
}

scoring('60 x N, where N is the number of valid colors you fit into the grid correctly.');
hvlth($page, 'writE out Te engliS version of Tis passagE on');


# Add another page
new_puzzle('Seeing is Describing');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
Pick two members of the team to be describers, and one team member to be the answerer.  The answerer should report to the referee station, where they will remain for the next ten minutes.  At this point, the referee will carry a hidden object back to the two describers.  They have ten minutes to take as many detailed notes as they like about the object.  After ten minutes, the describers hand over their notes to the referee.  The referee hides the object again, and then brings the notes back to the answerer, still at the referee station.  Then, the answerer gets all these notes that the describers wrote, and, while separated from their team, gets as much time as they like to answer a battery of questions regarding aspects of the object.  The score for this item is based on how many correct answers the answerer makes based on the describers' notes.
EOF
);

scoring('10 easy questions scored at 50 points each, 5 medium questions scored at 100 points each, 5 hard questions scored at 200 points each.');
hvlth($page, 'Te appropriatE answer pagE in Te problem');


# Add another page
new_puzzle('Penny Wise, Path Foolish');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
Trace a path through this maze, from the upper left to the bottom right.  You may not go over the same path twice, nor cross your own path, but you may visit an intersection multiple times.  As you visit an intersection, apply the adjustment listed to a running total.
EOF
);

# 792 x 612
longline($page, [60, 680], [560, 680], [560, 80]);
longline($page, [60, 660], [60, 60], [560, 60]);
foreach my $x (0 .. 3) {
	foreach my $y (0 .. 5) {
		my($X, $Y, $dx, $dy) = (80, 660, 100, 80);
		linkline($page,
			[$X+$x*($dx+20), $Y-10-$y*($dy+20)],
			[$X+10+$x*($dx+20), $Y-$y*($dy+20)],

			[$X-10+$dx+$x*($dx+20), $Y-$y*($dy+20)],
			[$X+$dx+$x*($dx+20), $Y-10-$y*($dy+20)],

			[$X+$dx+$x*($dx+20), $Y+10-$dy-$y*($dy+20)],
			[$X-10+$dx+$x*($dx+20), $Y-$dy-$y*($dy+20)],

			[$X+10+$x*($dx+20), $Y-$dy-$y*($dy+20)],
			[$X+$x*($dx+20), $Y+10-$dy-$y*($dy+20)],
		);
	}
}
{
	my($x,$y) = (70, 665);
	foreach(qw(
		+5 -3 -2 -1 +6
		+1 +2 +1 x2 -1
		+4 -4 -1 +3 -1
		-1 +3 x3 -5 +3
		+5 -1 +2 +3 -4
		+1 x2 -2 -1 +2
		+1 +1 +3 +1 -3
		) ) {
		$page->stringc($Helvetica, 12, $x, $y, $_);
		$x += 120;
		if($x/560 > 1) {
			$x = 70;
			$y -= 100;
		}
	}
}

scoring('The total that you have after exiting the maze.');
hvlth($page, 'booklet and present it to Te referee');


# Add another page
$page = $root->new_page;
$pdf->new_outline(Title => 'Solve This');
$page->stringl($Times_Bold, 18, 226, 774, $Question_Number++.'.');

sub hvlth_title {
	my $page = shift;

	my $starting = 306 - length($_[0])*7;

	my $position = 0;
	foreach(letter_convert(split //, $_[0]) ) {
		$$_[0] += $starting + $position foreach(@$_);
		$$_[1] += 766 foreach(@$_);
		longline($page, @$_);
		$position += 14;
	}
}
hvlth_title($page, 'solvE Tis');
scoring('100 per glyph.');



# Add another page
new_puzzle('Stacked');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
You have been given the Ace through four, in each suit, of a deck of cards.  Your goal is to arrange these sixteen cards into stacks with a variety of orders to generate a sum.  Each card affects this sum differently:
EOF
);

$page->stringl($Times, 12, 40, 710, << 'EOF'
	  * Hearts add the amount (1, 2, 3, or 4) on the card to the total
	  * Spades subtract the amount (1, 2, 3, or 4) on the card from the total
	  * Clubs multiply the next increase or decrease by the amount on the card (1, 2, 3, or 4)
	  * Diamonds jump to the next card indicated by the value on the card (1, 2, 3, or 4)
EOF
);

$page->blockl($Times, 12, 40, 640, 550, << 'EOF'
Clubs' multipliers are additive; a three of clubs stacks with an ace of clubs to become a total of a x4 multiplier (1 + 3 = 4).  Using these cards, place them in a stack that generates a given sum.  Start at the beginning of the stack, and remove each card as it is used.  The card instructions "wrap around", so arriving at the end of the stack means continuing from the beginning.  Continue until all the cards are gone from the stack.  An important restriction, however, is that no two cards of the same suit may be used in succession; a different suit must be used between them.  Thus, AH2H is invalid, as is 2DAH3D.  Write down the order of cards on the line next to the sum it generates.  All cards must be used in generating each number.
EOF
);

$page->blockl($Helvetica, 12, 40, 550, 550, << 'EOF'
Example: the sequence AH,4D,2S,3C,2H,AS would be run as follows: AH [0+1=1] 4D [Skip to the fourth-next card, AS] AS [1-1=0.  Wrap around to the beginning, 2S]  2S [0-2=-2] 3C [next card gets x3 to value] 2H [0+2(x3)=6], for a total of six.
EOF
);

foreach(0 .. 15) {
	my $line = 490 - 27 * $_;
	$page->stringr($Times, 14, 45, $line, $_);
	$page->line(50, $line, 500, $line);
}

scoring('50 x N, where N is the number of distinct sums that you find stacks for.');
$page = $root->new_page;

foreach(16 .. 39) {
	my $line = 1150 - 27 * $_;
	$page->stringr($Times, 14, 45, $line, $_);
	$page->line(50, $line, 500, $line);
}


# Add another page
new_puzzle('Pop Quiz');

sub question {
	my $page = shift;
	my($X, $Y, $text, $answers, $lines) = @_;

	$page->blockl($Times, 12, $X, $Y, 137, $text);
	foreach('A' .. 'E') {
		$page->stringl($Times, 12, $X, $Y-12*(ord()-65)-12*$lines,
			"$_) " . $$answers[ord()-65]);
	}
}

question($page, 25, 750,
	'1. The first question whose answer is B is:',
	[1 .. 5], 2,
);
question($page, 175, 750,
	'2. The only two consecutive questions with identical answers are questions:',
	['6 and 7', '7 and 8', '8 and 9', '9 and 10', '10 and 11',], 3,
);
question($page, 325, 750,
	'3. The number of questions with answer E is:',
	[0 .. 4], 2,
);
question($page, 475, 750,
	'4. The number of questions with answer A is:',
	[4 .. 8], 2,
);

question($page, 25, 640,
	'5. The answer to this question is the same as the answer to question:',
	[1 .. 5], 3,
);
question($page, 175, 640,
	'6. The answer to question 17 is:',
	[qw(C D E), 'none of the above', 'all of the above'], 2,
);
question($page, 325, 640,
	'7. Alphabetically, the answer to this question and the answer to the following question are:',
	['4 apart', '3 apart', '2 apart', '1 apart', 'the same'], 4,
);
question($page, 475, 640,
	'8. The number of questions whose answers are vowels is:',
	[4 .. 8], 3,
);

question($page, 25, 520,
	'9. The next question with the same answer as this one is question:',
	[10 .. 14], 3,
);
question($page, 175, 520,
	'10. The answer to question 16 is:',
	[qw(D A E B C)], 2,
);
question($page, 325, 520,
	'11. The number of questions preceding this one with the answer B is:',
	[0 .. 4], 3,
);
question($page, 475, 520,
	'12. The number of questions whose answer is a consonant is:',
	['an even number', 'an odd number', 'a perfect square', 'a prime', 'divisible by 5'], 3,
);


question($page, 25, 400,
	'13. The only odd-numbered question with answer A is:',
	[qw(9 11 13 15 17)], 2,
);
question($page, 175, 400,
	'14. The number of questions with answer D is:',
	[6 .. 10], 2,
);
question($page, 325, 400,
	'15. The answer to question 12 is:',
	['A' .. 'E'], 2,
);
question($page, 475, 400,
	'16. The answer to question 10 is:',
	[qw(D C B A E)], 2,
);

question($page, 25, 280,
	'17. The answer to question 6 is:',
	[qw(C D E), 'none of the above', 'all of the above'], 2,
);
question($page, 175, 280,
	'18. The number of questions with answer A equals the number of questions with answer:',
	[qw(B C D E), 'none of the above'], 4,
);
question($page, 325, 280,
	'19. The answer to this question is:',
	['A' .. 'E'], 2,
);
question($page, 475, 280,
	'20. The answer to this question is:',
	['not A, B, C, or E', 'not A, B, C, or D', 'not A, C, D, or E', 'not B, C, D, or E', 'not A, B, C, or D'], 2,
);
scoring('100 x N, where N is the number of consistent, correct answers.');


# Add another page
new_puzzle('You Want Candy');

$page->blockl($Times, 12, 40, 754, 550, << 'EOF'
One of your materials is a long candy necklace, with the colored pieces strung onto it in a random order.  Your task is to remove enough pieces from the string that the remaining pieces are a regular, recurring pattern.  The resultant pattern must repeat at least twice on the string, but may be of any length.  Any pieces that are not part of this pattern must be removed, i.e., all pieces on the string must be part of the recurring pattern.  Note that removing pieces from the string, though tasty, is a one-way trip!  The six colors available are Red, Yellow, Blue, Green, Orange, and White.
EOF
);
$page->blockl($Helvetica, 12, 40, 670, 550, << 'EOF'
Example: If the pieces on the string are Red, Yellow, Red, Yellow, Green, Red, Yellow, Blue, then the Green and Blue pieces can be removed to create the recurring pattern of Red-Yellow.
EOF
);

scoring('N x L x 50, where N is the number of times the pattern repeats, and L is the length of the pattern.');


$pdf->close;
