#!/usr/bin/perl

use strict;
use warnings;

# convert_to_utf-8()
# This script is meant for mp3 tags written in Cyrillic
# This program converts all tags to the cyrillic encoding
# of your choice.
# Itunes can only read UTF-8.
#
#
# Usage:
# drag files to be converted over the script icon.
# Bugs:
#    written by somebody who doesn't know perl
#   the ID3v2 section doesn't work
#
#
use MP3::Tag;
use Convert::Cyrillic;
use Lingua::DetectCharset;

#    Declare what the encoding encoding will be
# $encoding="UTF-8" for itunes
# #encoding="VOL" for transliteration
my $encoding="UTF-8";

foreach my $file (@ARGV)
{
	my $mp3 = MP3::Tag->new($file);
	$mp3->get_tags();

	# ID3v2 section
	if(my $id3v2 = $mp3->{ID3v2}) {
		my $frameIDs_hash = $id3v2->get_frame_ids('truename');
		# This might not work if there is a large amount of binary data in the
		# fields, or mixed encodings (say, English and Russian).  Remove any
		# that seem to be mostly English.
		my $source = Lingua::DetectCharset::Detect(join ' ', grep !/[a-z]/i, values %$frameIDs_hash);
		#print "$source\n";

		foreach my $frame (keys %$frameIDs_hash) {
			my ($value, $key, %rest) = $id3v2->get_frame($frame);
			# Binary fields begin with an underscore, do not convert them
			next if $key =~ /^_/;
			#print "\t$key => $value\n";

			if(ref $value) {
				my %new_hash = map {
					#print "\t\t$_ => $$value{$_}\n";
					# Binary fields begin with an underscore, do not convert them
					$_ => /^_/ ? $$value{$_} : Convert::Cyrillic::cstocs($source, $encoding, $$value{$_})
				} keys %$value;
				if(!defined $id3v2->change_frame($frame, 3, \%new_hash, $key) ) {
					die "Could not change [$frame][%new_hash][$key] from [%$value]";
				}
			}
			else {
				my $new = Convert::Cyrillic::cstocs($source, $encoding, $value);
				next if $new eq $value;
				if(!defined $id3v2->change_frame($frame, 3, $new, $key) ) {
					die "Could not change [$frame][$new][$key] from [$value]";
				}
			}
		}
		$id3v2->write_tag;
	}

	# MP3 V1
	if (exists $mp3->{ID3v1})
	{
		my $id3v1 = $mp3->{ID3v1} ;
		my @tagdata=$id3v1->all;
		my $charset = Lingua::DetectCharset::Detect(@tagdata);
		if ($charset ne "UTF-8")
		{
			my $transtag = Convert::Cyrillic::cstocs($charset, $encoding, @tagdata);
			$mp3->{ID3v1}->all($transtag);
			#print($mp3->{ID3v1}->all);
			#$mp3->{ID3v1}->write_tag();
		}
	}

	$mp3->close();
}
