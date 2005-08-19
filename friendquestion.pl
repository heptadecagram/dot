#!/usr/bin/perl
# Project  Name: None
# File / Folder: friendquestion.pl
# File Language: perl
# Copyright (C): 2005 Richard Group, Inc.
# First  Author: Liam Bryan
# First Created: 2005.08.17 09:33:33
# Last Modifier: Liam Bryan
# Last Modified: 2005.08.18 16:26:39

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
What would happen if you were to date ?
What is the strangest thing ? has ever said to you
What do ? and ? have in common
What would happen if ? and ? went on a date together
What happened the last time you and ? were hanging out together
Why shouldn't ? and ? be a couple
What is ?'s favorite band
What is ?'s favorite book
What is ?'s favorite movie
What is ?'s favorite song
What is ?'s favorite meal
What is ?'s fantasy
When was the last time you talked to ?
Is ? evil
What does ? spend the most time doing
Who on your friends list would get along best with ?
How did you meet ?
How many siblings does ? have
What is the most embarrassing thing you know about ?
What would your life be like if you had never met ?
Does ? have a funny-shaped head or what
What was the last game you played with ?
Where do you think ? is right now
Who would win in a fight between ? and ?
Why did ? cross the road
Whom does ? get along best with
If you had the chance to sleep with ?, would you
Whom is ? attracted to
Can ? raise the dead to perform common household tasks
What do you find admirable about ?
What habit does ? have that you think they should give up
Could you take ? in a fight
What would ? like to do for a living
Of ?, ?, and ?, which one is most similar to ?
Do you envy ?'s job
What do you most envy about ?
Where would you take ? on a vacation
Would you sooner donate a kidney to ? or ?
In what ways are you smarter than ?
In what ways is ? smarter than you
What kind of underwear does ? wear
Does ? spend too much time on LiveJournal
Why would ? go to heaven but ? go to hell
Of ? and ?, who would call shotgun first
Who would make a better stuffed animal, ? or ?
What's up with ?
How many people has ? seduced
When's the last time you saw ?
Can ? solve a Rubik's Cube
What is ?'s religion
How many licks would ? take to get to the center of a Tootsie Pop
Does ? look better with long hair
Does ? know how to spell the word 'embarrass' correctly
What's the biggest difference between ? and ?
Will ? ever amount to anything
Did ? leave the stove on again
What animal does ? most remind you of
After a cataclysmic war, whom would you pair with ? to repopulate the Earth
Did ? steal the cookie from the cookie jar
Why is ? sneaking up behind you right now
Can ? do a headstand
How would ? survive on a desert island
If ? and ? were superheroes, which one would be the sidekick
What is ?'s sexiest feature
What four adjectives best describe ?
Would ? be better described as a hero or a villian
Have you ever seen ? naked
Is ?'s spoon too big
Is ? best described as a badger, a mushroom, or a snake
Is ? hiding under your bed right now
What was ? wearing, the last time you noticed
Shouldn't ? be getting more sleep
Is ? an innie or an outie
Can ? become invisible at will
What political beliefs of ? do you disagree with
Have you ever suspected ? of being a lifelike robot
What would you most like to do with ?
What's the last thing you said to ?
What kind of person would you set up with ?
What do you think of when you see ?
What do you think of ?'s family
What does ? think of America's involvement in Iraq
Does ? understand quantum chromodynamics
?: pansy, or wuss
?: ninja, pirate, monkey, or robot
Where did ? leave the remote
Doesn't ? have anything better to do
How long have you known ?
Is ? a morning person or a night person
? is in a maze of twisty passages, all alike.  What now
Did ? take the blue pill, or the red pill
What would ? be like on an LSD trip
It's all ?'s fault, isn't it
What hobby do you think ? should take up
What would ? and ? inherit from ?'s will
What historical figure does ? most remind you of
What will be ?'s last words
Would ? look better not wearing pants, or not wearing a shirt
What kind of book would ? and ? jointly write
What would ? do with half a million dollars (U.S.)
What is ? allergic to
What would the minions of ?'s army look like
How will ? die
What is the most insightful thing you have heard ? say
What does ? look for in a significant other
Who would make a better window-washer, ? or ?
What will ? be like in twenty years
