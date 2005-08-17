#!/usr/bin/perl
# Project  Name: None
# File / Folder: friendquestion.pl
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.08.17 09:33:33
# Last Modifier: Liam Bryan
# Last Modified: 2005.08.17 15:07:45

use strict;
use warnings;

use Net::HTTP;

my $name = lc 'heptadecagram';

die 'Not a valid LiveJournal name' if($name =~ tr/a-z_0-9// || length($name) > 20);

my $s = Net::HTTP->new(Host => 'www.livejournal.com') || die $@;
$s->write_request(GET => "/misc/fdata.bml?user=$name", 'User-Agent' => 'Liam');
my($code, $message) = $s->read_response_headers;

die $message if($code != 200);

my $names;
while(1) {
	my $buffer;
	my $read = $s->read_entity_body($buffer, 1024);
	$names .= $buffer;
	last unless($read);
}

die $names if($names =~ /^!/);

my @friends = map {substr($_, 2)} grep /^>/, split "\n", $names;
chomp(@friends);
@friends = (shuffle(grep { $_ ne $name } @friends) )[0 .. 19];

sub shuffle {
	map{$$_[0]}sort{$$a[1]<=>$$b[1]}map{[$_,rand]}@_;
}


print qq(<ol style="list-style-type: upper-roman;">\n);
foreach(@friends) {
	print qq(<li><lj user="$_"></li>\n);
}
print "</ol>\n";

__DATA__
What would happen if you were to date ?
What is the strangest thing ? has ever said to you
What do ? and ? have in common
What would happen in ? and ? went on a date together
What is ?'s favorite band
What is ?'s favorite movie
What is ?'s fantasy
When was the last time you talked to ?
How did you meet ?
How many siblings does ? have
What is the most embaressing thing you know about ?
What would your life be like if you had never met ?
Where do you think ? is right now
Who would win in a fight between ? and ?
What is ?'s favorite song
Why did ? cross the road
Who does ? get along best with
If you had the chance to sleep with ?, would you
Who is ? attracted to
Could you take ? in a fight
If ? and ? were cursed such that one had to die for the other to live, who would die and who would live
What would ? like to do for a living
Of ?, ?, and ?, which one is most similar to ?
Do you envy ?'s job
What do you most envy about ?
Where would you take ? on a vacation
Would you sooner donate a kidney to ? or ?
