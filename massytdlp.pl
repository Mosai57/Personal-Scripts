#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp qw(read_file);

my @links = read_file($ARGV[0]);
my $t_count = scalar(@links);
my $ctr = 0;

foreach(@links){
	$ctr++;
	if($_ =~ /^#/){
		print "$ctr: $_";
	} else{
		print "$ctr of $t_count: $_ ... ";
		`yt-dlp --cookies-from-browser firefox -f 'bestvideo+bestaudio' --embed-thumbnail --merge-output-format mp4 $_`;
	}
}

print "All links downloaded\n";
