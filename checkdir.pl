#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @folders;

my @directories = (
	"/media/internal/plex/dr2/Anime",
	"/media/internal/plex/dr3/Anime",
	"/media/internal/plex/dr4/Anime",
);

foreach(@directories){
	opendir my $dh, $_, or die "$!";
	push @folders, readdir($dh);
	close $dh;
}

foreach(sort @folders){
	if($_ =~ /\.+$/){ next; }

	print "Found: [ $_ ] ";
	<>;
}
