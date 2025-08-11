#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;

my $cur_dir = getcwd;
opendir(BIN, $cur_dir) or die "Can't open $cur_dir: $!";
my @files = grep { /\.mp4$/ } readdir BIN;
close (BIN);

foreach(@files){
	my $old_title = $_;
	$old_title =~ s/.mp4//;

	my ($series, $title, $index) = split(" - ", $_);
	$index =~ /S\d+E(\d+)/;	
	my $new_title = "$series - $1 - $title.m4a";
	
	print "$_\n\t->$new_title\n\n";
	rename ($_, $new_title) or die "Error in renaming $_: $!";
}
