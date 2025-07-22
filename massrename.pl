#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
use File::Slurp;

my $dir = getcwd();
opendir(my $dh, $dir) || die "Can't opendir $dir $!";
my @mp3s = grep { /\.mp3$/ } readdir($dh);
closedir $dh;

my @filenames = read_file($filename);
s/\n// for @filenames;
@mp3s = sort {$a cmp $b} @mp3s;
s/\n// for @mp3s;
s/\r// for @mp3s;

#print scalar(@filenames) . " | " . scalar(@mp3s) . "\n";
if(scalar(@mp3s) == scalar(@filenames)){
	my $max = scalar(@mp3s);
	my $idx = 0;
	while($idx < $max){
		my $old = "$mp3s[$idx]";
		my $new = "$filenames[$idx].mp3";
		rename($old, $new);
		$idx += 1;
	}
}
