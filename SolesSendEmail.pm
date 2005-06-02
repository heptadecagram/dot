package CMS::Survey::FinishAction::SolesSendEmail;
our($VERSION);
$VERSION = "0.01";
# Revisions
#
# Date       Who   Ver    Comments
# -------------------------------------------------------------------------------------------------------
# 08/25/2004 JMR   0.01   - Created
# 05/24/2005 JMR   0.10   - Combined all of the soles email reuqests into this one handler. Decides what
#                           to do based on the survey id passed in.
# -------------------------------------------------------------------------------------------------------

use Apache2;
use Apache::Reload;
use CGI qw(&param &header &cookie &redirect &upload);
use CGI::Carp qw(fatalsToBrowser);
use strict;
use URI::Escape;
use Net::SMTP;


sub get_name_from_value {
	my $value = shift;
	my $displayvalues = shift;
	my $savevalues = shift;

	my @display = split(/\|/, $displayvalues);
	my @values = split(/\|/, $savevalues);
	for (0..@values-1) {
		if (lc($values[$_]) eq lc($value)) {
			return $display[$_];
		}
	}
	return '';
}

sub handler {
	my $self = shift;
	my $dbh = shift;	
	my $prefix = shift;
	my $surveyid = shift;
	my $timestamp = shift;
	my $destination_url = shift;
	
	my $edbh = DBI->connect("DBI:Pg:dbname=emailer_davidrichard;host=10.0.0.2",'emailer','mail');
	&send_catalog   ($dbh, $edbh, $prefix, $timestamp, $surveyid) if ($surveyid == 5);
	&send_feedback  ($dbh, $edbh, $prefix, $timestamp, $surveyid) if ($surveyid == 3);
	&send_contactus ($dbh, $edbh, $prefix, $timestamp, $surveyid) if ($surveyid == 4);
	$edbh->disconnect();
	
	return undef;
}

sub new {
	my $class = shift;
	my $self = {};
	bless $self, $class;
	return $self;
}

sub send_catalog {
	my $dbh = shift;	
	my $edbh = shift;	
	my $prefix = shift;
	my $timestamp = shift;
	my $surveyid = shift;

	my $from_email = "info\@simplysoles.com";
	my $recipient_email = "info\@simplysoles.com";
#	my $from_email = "joel\@joelrichard.com";
#	my $recipient_email = "joel\@joelrichard.com";

 	# 1. Given the timestamp get the record from the database
 	my $q = $dbh->selectrow_arrayref("select mailer_contactid, bfirst, blast, baddres1, bcityb, bstateb1, bzip, age1, annual, how from ".$prefix."_survey_responses_$surveyid where datetime = '$timestamp'");
	my $q_annual = $dbh->selectrow_arrayref("select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = $surveyid and fieldname = 'annual'");
	my $q_age = $dbh->selectrow_arrayref("select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = $surveyid and fieldname = 'age1'");
	my $q_budget = $dbh->selectrow_arrayref("select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = $surveyid and fieldname = 'how'");
 	# 2. Get the contact fields and use them to populate the fields for Opt-Intelligence
	# Update the newsletter setting
	my $q_contact = $edbh->selectrow_arrayref("select email from ss_contacts where contactid ".($q->[0] ? ' = '.$q->[0] : 'is null'));
	$edbh->do("update ss_contacts set first=?, last=?, street_address=?, city=?, state=?, zip=?, source=? where contactid = ?",
	          undef, ($q->[1], $q->[2], $q->[3], $q->[4], $q->[5], $q->[6], 'Catalog Request', $q->[0]) ) if ($q->[0]);
	
	my $smtp = Net::SMTP->new('localhost');
	$smtp->mail($from_email);
	$smtp->to($recipient_email);
	$smtp->bcc("joel\@joelrichard.com");
	$smtp->data();
	$smtp->datasend("Return-Path: $from_email\n");
	$smtp->datasend("To: $recipient_email\n");
	$smtp->datasend("From: $from_email\n");
	$smtp->datasend("Subject: [simplysoles] Catalog Request\n\n");

	$smtp->datasend("The following catalog request was submitted on the www.simplysoles.com website\n\n");
	$smtp->datasend($q->[1].' '.$q->[2]."\n");
	$smtp->datasend($q->[3]."\n");
	$smtp->datasend($q->[4].", ".$q->[5]." ".$q->[6]."\n\n");
	$smtp->datasend("E-mail:                    ".($q_contact->[0]||'(not supplied)')."\n");
	$smtp->datasend("Age:                       ".get_name_from_value($q->[7], $q_age->[0], $q_age->[1])."\n");
	$smtp->datasend("Shoe Budget:               ".get_name_from_value($q->[8], $q_annual->[0], $q_annual->[1])."\n");
	$smtp->datasend("How did you hear about us: ".get_name_from_value($q->[9], $q_budget->[0], $q_budget->[1])."\n");
	$smtp->dataend();
	$smtp->quit;
}

sub send_feedback {
	my $dbh = shift;	
	my $edbh = shift;	
	my $prefix = shift;
	my $timestamp = shift;
	my $surveyid = shift;

	my $from_email = "info\@simplysoles.com";
	my $recipient_email = "info\@simplysoles.com";
#	my $from_email = "joel\@joelrichard.com";
#	my $recipient_email = "joel\@joelrichard.com";

 	# 1. Given the timestamp get the record from the database
 	my $q = $dbh->selectrow_arrayref("select mailer_contactid, bcontac, bquesti from ".$prefix."_survey_responses_$surveyid where datetime = '$timestamp'");
 	warn "select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = $surveyid and fieldname = 'bcontac'";
	my $q_contactvals = $dbh->selectrow_arrayref("select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = $surveyid and fieldname = 'bcontac'");
 	# 2. Get the contact fields and use them to populate the fields for Opt-Intelligence
 	if ($q->[0]) {
 		# Update the newsletter setting
 		my $q_contact = $edbh->selectrow_arrayref("select email, first, last from ss_contacts where contactid = ".$q->[0]);
		$edbh->do("update ss_contacts set source='Feedback Form' where contactid = ".$q->[0]) if ($q->[0]);
		
		my $smtp = Net::SMTP->new('localhost');
		$smtp->mail($from_email);
		$smtp->to($recipient_email);
		$smtp->bcc("joel\@joelrichard.com");
		$smtp->data();
		$smtp->datasend("Return-Path: $from_email\n");
		$smtp->datasend("To: $recipient_email\n");
		$smtp->datasend("From: $from_email\n");
		$smtp->datasend("Subject: [simplysoles] Feedback submission\n\n");

		$smtp->datasend("The following was submitted on the www.simplysoles.com Feedback form\n\n");
		$smtp->datasend("First Name:  ".$q_contact->[1]."\n");
		$smtp->datasend("Last Name:   ".$q_contact->[2]."\n");
		$smtp->datasend("E-mail:      ".$q_contact->[0]."\n");
		warn "Contacting ..".$q->[1];
		$smtp->datasend("Contact:     ".get_name_from_value($q->[1], $q_contactvals->[0], $q_contactvals->[1])."\n");
		$smtp->datasend("Comments: \n".$q->[2]."\n");
		$smtp->dataend();
		$smtp->quit;
	}
}

sub send_contactus {
	my $dbh = shift;	
	my $edbh = shift;	
	my $prefix = shift;
	my $timestamp = shift;
	my $surveyid = shift;

	my $from_email = "info\@simplysoles.com";
	my $recipient_email = "info\@simplysoles.com";
#	my $from_email = "joel\@joelrichard.com";
#	my $recipient_email = "joel\@joelrichard.com";

	warn "entering send_contactus";
 	# 1. Given the timestamp get the record from the database
 	my $q = $dbh->selectrow_arrayref("select mailer_contactid, bquesti1 from ".$prefix."_survey_responses_$surveyid where datetime = '$timestamp'");
	my $q_question = $dbh->selectrow_arrayref("select displayvalues, savevalues from ".$prefix."_survey_questions where surveyid = 2 and fieldname = 'how1';");
 	# 2. Get the contact fields and use them to populate the fields for Opt-Intelligence
 	if ($q->[0]) {
 		# Update the newsletter setting
 		my $q_contact = $edbh->selectrow_arrayref("select email, first, last from ss_contacts where contactid = ".$q->[0]);
		$edbh->do("update ss_contacts set source='Contact Us Form' where contactid = ".$q->[0]) if ($q->[0]);
		
		my $smtp = Net::SMTP->new('localhost');
		$smtp->mail($from_email);
		$smtp->to($recipient_email);
		$smtp->bcc("joel\@joelrichard.com");
		$smtp->data();
		$smtp->datasend("Return-Path: $from_email\n");
		$smtp->datasend("To: $recipient_email\n");
		$smtp->datasend("From: $from_email\n");
		$smtp->datasend("Subject: [simplysoles] Contact Us submission\n\n");

		$smtp->datasend("The following was submitted on the www.simplysoles.com Contact Us form\n\n");
		$smtp->datasend("E-mail:   ".$q_contact->[0]."\n");
		$smtp->datasend("Name:     ".$q_contact->[1].' '.$q_contact->[2]."\n");
		$smtp->datasend("Comments: \n".$q->[1]."\n");
		$smtp->dataend();
		$smtp->quit;
	}
	warn "leaving send_contactus";
}

sub get_name_from_value {
	my $value = shift;
	my $displayvalues = shift;
	my $savevalues = shift;

	my @display = split(/\|/, $displayvalues);
	my @values = split(/\|/, $savevalues);
	for (0..@values-1) {
		if (lc($values[$_]) eq lc($value)) {
			return $display[$_];
		}
	}
	return '';
}

1;
