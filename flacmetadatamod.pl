#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;

my $dir = getcwd();

print $dir . "\n";

opendir(my $dh, $dir) || die "Can't opendir $dir $!";
my @mp3s = grep { /\.flac$/ } readdir($dh);
closedir $dh;

@mp3s = sort {$a cmp $b} @mp3s;
s/\n// for @mp3s;

my @titles = @mp3s;

s/^\d+ - // for @titles;
s/\.flac$// for @titles;

my $ctr = 0;
foreach my $track (@mp3s){
#	print "id3v2 -t \"$titles[$ctr]\" \"$track\"\n";
	print "Set title for [ $track ] to ( $titles[$ctr] )\n";
	`id3v2 -t \"$titles[$ctr]\" \"$track\"`;
	$ctr++;
}
