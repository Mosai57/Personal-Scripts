#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

sub choose_drive {
	my @output;
	my @lines = `df | grep -E 'dr[3-4]'`;

	foreach(@lines){
		my @exp_line = split(/\s+/, $_);
		my $line = $exp_line[3] . " " . $exp_line[5] . "\n";
		chomp $line;
		push @output, $line;
	}

	@output = sort @output;
	my ($size, $drive) = split(/\s+/, $output[2]);
	return $drive;
}

my $drop_dir = "/media/internal/other/dr1/toMove";
opendir my $dh, $drop_dir or die "$!";
my @folders = readdir($dh);
close $dh;

foreach(@folders){
	if($_ =~ /\.+$/){
		next;
	}
	if(!(-d "$drop_dir/$_")){
		print "Skipping $_\n";
		next;
	}
	my $drive = choose_drive();
	print "Moving $_ to $drive/Anime\n";
	`mv "$drop_dir/$_" "$drive/Anime"`;
	#	`rm -rf $drop_dir/$_`;
}


