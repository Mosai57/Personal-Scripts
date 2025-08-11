#!/usr/bin/env perl
use strict;
use warnings;
use Capture::Tiny ':all';
use Cwd;
use Data::Dumper;

my $cwd = getcwd;
my @total_time = (0, 0, 0); #h, m, s

opendir(BIN, $cwd) or die "Can't open $cwd: $!";
my @files = grep { /\.((mp4)|(m4v)|(avi)|(webm)|(mkv))$/ } readdir BIN;
close (BIN);

foreach(@files){
	my($stdout, $stderr, $exit) = capture { system( "ffprobe", $_ ); };
	my @lines = split('\n', $stderr);
	my $duration_line;
	foreach(@lines){
		if($_ =~ /Duration/i){
			$duration_line = $_;
		}
	}
	$duration_line =~ /(\d{2}:\d{2}:\d{2})\.\d+/;
	my $duration = $1;
	#print "$_ - $duration\n";
	add_time($duration);
	print "$duration\n";
}
print "Total: " . $total_time[0] . ":" . sprintf("%02d", $total_time[1]) . ":" . sprintf("%02d", $total_time[2])  . "\n";

sub add_time {
	my @file_time = split(':', shift);
	
	# Seconds
	my $seconds = $total_time[2] + $file_time[2];
	$total_time[1] += int($seconds / 60);
	$total_time[2] = $seconds % 60;

	# Minutes
        my $minutes = $total_time[1] + $file_time[1];
        $total_time[0] += int($minutes / 60);
        $total_time[1] = $minutes % 60;

	# Hours
	$total_time[0] += $file_time[0];
}
