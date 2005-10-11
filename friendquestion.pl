#!/usr/bin/perl
# Project  Name: None
# File / Folder: friendquestion.pl
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.08.17 09:33:33
# Last Modifier: Liam Bryan
# Last Modified: 2005.08.30 06:26:07

use strict;
use warnings;

use DBI;
use CGI;
use Net::HTTP;
use HTML::Template;

$SIG{__DIE__} = sub {
	my $Page = HTML::Template->new(
		filename => 'template.html',
		path => [ '/home/heptad3/public_html/' ],
	);

	$Page->param(content => "<p>$_[0]</p>");
	$Page->param(title => ' : The Completely Random Question Meme!');

	print $Page->output;
};

my $q = CGI->new;

sub shuffle {
	map{$$_[0]}sort{$$a[1]<=>$$b[1]}map{[$_,rand]}@_;
}

sub LJify {
	local $_ = $_[0];
	1 while(s#<lj user=("?)(\w+)\1>#<span class='ljuser' style='white-space: nowrap;'><a href='http://www.livejournal.com/userinfo.bml?user=$2'><img src='http://stat.livejournal.com/img/userinfo.gif' alt='[info]' width='17' height='17' style='vertical-align: bottom; border: 0;'/></a><a href='http://www.livejournal.com/users/$2/'><b>$2</b></a></span>#);
	$_;
}

my $index;
my %questions = map { (++$index, $_) } (<DATA>);

print "Content-Type: text/html\n\n";

my $text = '';

if($q->param('done') ) {
	my $params = $q->Vars();
	$text = '<dl>';
	foreach(grep /^k\d+$/, keys %$params) {
		/^k(\d+)$/;
		my $v = "v$1";
		$text .= qq(<dt style="font-weight: bold;">$$params{$_}?</dt>);
		$$params{$v} =~ s#\r?\n\r?#<br/>#g;
		$text .= qq(<dd style="padding-bottom: .4em;">$$params{$v}</dd>);
	}
	$text .= '</dl><p style="float: right; font-size: smaller; width: 20em;">This is by <lj user="heptadecagram">.  You can find your own completely random questions <a href="http://heptadecagram.net/cgi-bin/friendquestion.pl">here</a>.</p><p style="clear: both;">Do you feel enlightened now?</p>';

	$text = '<h2>Your Answers!</h2>' . LJify($text) . '<h3 style="clear: both;">How to Post this in your LiveJournal</h3><p>Copy and paste the text in the box below.  There is a lot of text, mind you.  And it even comes with an LJ-cut tag made for you!</p><textarea rows="14" cols="60">&lt;lj-cut text="The Random Question Meme!"&gt;&lt;h3&gt;The Random Question Meme!&lt;/h3&gt;&lt;p&gt;An array of completely random questions about my friends!&lt;/p&gt;'.$q->escapeHTML($text).'&lt;/lj-cut&gt;</textarea>';

}
elsif(my $name = lc $q->param('name') ) {
	die 'Not a valid LiveJournal name' if($name =~ tr/a-z_0-9//c || length($name) > 15);

	my $question_count = $q->param('count');
	$question_count = 10 if($question_count =~ tr/0-9//c || $question_count < 1);
	$question_count = 60 if($question_count > 60);

	my $dbh = DBI->connect('DBI:mysql:dbname=heptad3_content',
		'heptad3_livejour', '0l9r8c7g') or die DBI->errstr;

	my @friends;

	my($cached) = $dbh->selectrow_array(q{
		SELECT SUBDATE(NOW(), INTERVAL 1 DAY) <= last_check
		FROM LJ_user
		WHERE username = ?
		}, undef,
		$name,
	);

	if(!$cached) {
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

		@friends = map {substr($_, 2)} grep /^>/, split "\n", $names;
		chomp(@friends);

		foreach(@friends) {
			$dbh->do('INSERT INTO LJ_friend_of (user, friend) VALUES (?, ?)',
				undef,
				$name, $_,
			);
		}
		$dbh->do('REPLACE INTO LJ_user (username, last_check) VALUES (?, NOW() )',
			undef,
			$name,
		);
	}
	else {
		my $friend_list = $dbh->selectcol_arrayref(q{
			SELECT friend FROM LJ_friend_of
			WHERE user = ?
			}, undef,
			$name,
		);

		@friends = @$friend_list;
	}

	$dbh->disconnect;

	@friends = shuffle(grep { $_ ne $name } @friends);

	my @q_index = shuffle(keys %questions);


	$text = qq(<h2>The Questions</h2><p>If you don't know an answer, guess!  It's more fun that way.</p><form method="post"><dl>\n);
	foreach my $number (0 .. $question_count-1) {
		local $_ = $questions{$q_index[$number]};
		last if(tr/?// > @friends);
		chomp;

		while(tr/?//) {
			s/\?/'<lj user="'.pop(@friends).'">'/e;
		}

		$text .= qq(<dt style="font-weight: bold;">) . LJify($_) . qq(?<input type="hidden" name="k$number" value=").$q->escapeHTML($_).qq("/></dt>\n);
		$text .= qq(<dd style="padding-bottom: .2em;"><textarea name="v$number" rows="5" cols="60"></textarea></dd>\n);
	}
	$text .= qq(</dl>\n<input type="submit" name="done" value="I'm done!"/></form>);
}
else {
	$text = q(
	<h2>The Random Questions Meme</h2>
	<form method="get">
		<fieldset style="width: 30em;">
			<caption>So, what's your LiveJournal name?</caption><br/>
			<label>
				<img src='http://stat.livejournal.com/img/userinfo.gif' alt='LiveJournal Username' width='17' height='17' style='vertical-align: bottom; border: 0;' />
				<input name="name" size="20" maxlength="15"/>
			</label><br/>
			<label>
				Number of questions
				<input name="count" value="10" size="5" maxlength="3"/>
			</label><br/>
			<input type="submit" value="Ask me questions"/>
		</fieldset>
	</form>

	<h4>What's going on here?</h4>
	<p>The deal is that you get about 10 completely random questions about your friends thrown back at you.  Answer them, and then this page will present you with the markup needed to put this in your LiveJournal.  If you don't like the questions/friends you are presented with, try reloading, and you'll get different ones.</p>

	<h4>Features!</h4>
	<ul>
		<li>Over 100 questions to show you! (Sorry, no more than 60 at at time)</li>
		<li>Ready-to-use LJ-cut when pasting into your journal!</li>
		<li>Is fun!</li>
		<li>Won't break your friends page with shoddy HTML!</li>
		<li>Uses correct grammar and spelling!</li>
		<li>Uses the Fisher-Yates shuffling algorithm for maximum fun!</li>
		<li>Help me, I'm trapped in a list!</li>
		<li>No banner ads!</li>
		<li>Made from 100% post-consumer recycled bytes!</li>
	</ul>
	);
}

my $Page = HTML::Template->new(
	filename => 'template.html',
	path => [ '/home/heptad3/public_html/' ],
);

$Page->param(content => $text);
$Page->param(title => ' : The Completely Random Question Meme!');

print $Page->output;

__DATA__
? is in a maze of twisty passages, all alike.  What now
?: ninja, pirate, monkey, or robot
?: pansy, or wuss
After a cataclysmic war, whom would you pair with ? to repopulate the Earth
Can ? become invisible at will
Can ? do a headstand
Can ? raise the dead to perform common household tasks
Can ? solve a Rubik's Cube
Could you take ? in a fight
Did ? leave the stove on again
Did ? steal the cookie from the cookie jar
Did ? take the blue pill, or the red pill
Do you envy ?'s job
Does ? have a funny-shaped head or what
Does ? know how to spell the word 'embarrass' correctly
Does ? look better with long hair
Does ? spend too much time on LiveJournal
Does ? understand quantum chromodynamics
Doesn't ? have anything better to do
Have you ever seen ? naked
Have you ever suspected ? of being a lifelike robot
How did you meet ?
How long have you known ?
How many licks would ? take to get to the center of a Tootsie Pop
How many people has ? seduced
How many siblings does ? have
How will ? die
How would ? survive on a desert island
If ? and ? were superheroes, which one would be the sidekick
If you had the chance to sleep with ?, would you
In what ways are you smarter than ?
In what ways is ? smarter than you
Is ? a morning person or a night person
Is ? an innie or an outie
Is ? best described as a badger, a mushroom, or a snake
Is ? evil
Is ? hiding under your bed right now
Is ?'s spoon too big
It's all ?'s fault, isn't it
Of ? and ?, who would call shotgun first
Of ?, ?, and ?, which one is most similar to ?
Shouldn't ? be getting more sleep
What animal does ? most remind you of
What do ? and ? have in common
What do you find admirable about ?
What do you most envy about ?
What do you think of ?'s family
What do you think of when you see ?
What does ? look for in a significant other
What does ? spend the most time doing
What does ? think of America's involvement in Iraq
What fictional character is ? most like
What four adjectives best describe ?
What habit does ? have that you think they should give up
What happened the last time you and ? were hanging out together
What historical figure does ? most remind you of
What hobby do you think ? should take up
What is ? allergic to
What is ?'s fantasy
What is ?'s favorite band
What is ?'s favorite book
What is ?'s favorite meal
What is ?'s favorite movie
What is ?'s favorite song
What is ?'s religion
What is ?'s sexiest feature
What is the most embarrassing thing you know about ?
What is the most insightful thing you have heard ? say
What is the strangest thing ? has ever said to you
What kind of book would ? and ? jointly write
What kind of person would you set up with ?
What kind of underwear does ? wear
What political beliefs of ? do you disagree with
What was ? wearing, the last time you noticed
What was the last game you played with ?
What will ? be like in twenty years
What will be ?'s last words
What would ? and ? inherit from ?'s will
What would ? be like on an LSD trip
What would ? do with half a million dollars (U.S.)
What would ? like to do for a living
What would happen if ? and ? went on a date together
What would happen if you were to date ?
What would the minions of ?'s army look like
What would you most like to do with ?
What would you say at ?'s funeral
What would your life be like if you had never met ?
What's the biggest difference between ? and ?
What's the last thing you said to ?
What's up with ?
When was the last time you talked to ?
When's the last time you saw ?
Where did ? go
Where did ? leave the remote
Where do you think ? is right now
Where would you take ? on a vacation
Who on your friends list would get along best with ?
Who would make a better stuffed animal, ? or ?
Who would make a better window-washer, ? or ?
Who would win in a fight between ? and ?
Whom does ? get along best with
Whom is ? attracted to
Why did ? cross the road
Why is ? sneaking up behind you right now
Why shouldn't ? and ? be a couple
Why would ? go to heaven but ? go to hell
Will ? ever amount to anything
Would ? be better described as a hero or a villain
Would ? look better not wearing pants, or not wearing a shirt
Would you sooner donate a kidney to ? or ?
