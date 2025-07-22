#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @d_inf = (
	{
		'folders'	=> [],
		'count'		=> 0,
		'size'		=> 0,
	},
	{
		'folders'	=> [],
		'count'		=> 0,
		'size'		=> 0,
	},
);

my @drive_size = (0, 0);

sub assign_drive {
	my $size = shift;
	my $drive;
	# if both drives are at the same size, we prio drive 1
	if($d_inf[0]{'size'} == $d_inf[1]{'size'}){
		$drive = 0;
	}

	# We assign the folder to thedrive that currently is smaller
	if($d_inf[0]{'size'} < $d_inf[1]{'size'}){
		$drive = 0;
	} elsif ($d_inf[0]{'size'} > $d_inf[1]{'size'}){
		$drive = 1;
	}

	$d_inf[$drive]{'size'} += $size;
	$d_inf[$drive]{'count'}++;
	return $drive;
}

sub format_gb {
	my $size = shift;
	return sprintf("%.2fG", (($size/1024)/1024));
}

my $focus = "/media/internal/plex/dr2/Anime/";
opendir(my $dh, $focus) or die "Cannot open directory: $focus | $!";
my @folders = readdir($dh);
close($dh);

@folders = sort(@folders);

foreach(@folders){
	# Skip . and ..
	next if $_ =~ /^\./g;

	# Get the unformatted results, and only grab the size
	my $raw_result = `du -d 0 \"$focus$_\"`;
	my $size = (split(/\s+/, $raw_result))[0];

	my $drive = assign_drive($size);

	# Assign the info to the hash
	push @{ $d_inf[$drive]{'folders'} }, $_;
}

#print Dumper @d_inf;
foreach my $idx (0..$#d_inf){
	print "Drive $idx: " . $d_inf[$idx]->{'size'} . " | " 
						 . $d_inf[$idx]->{'count'} . "\n";
}
#my $start_time = time();
#my $last_time = $start_time;

#print "Moving the following items:\n ";
#foreach( @{ $d_inf[1]{'folders'} } ){
#	print "Moving: $_ ... ";
#	`rsync -a -p --progress --remove-source-files \"$focus$_\" /media/internal/dr3/Anime/\n`;
#	my $cur_time = time();
#	print $cur_time - $last_time . " sec\n";
#}

#print "All files moved. Total time: " . (time() - $start_time) . "\n";
