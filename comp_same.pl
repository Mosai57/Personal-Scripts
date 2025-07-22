#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;

my $path1 = $ARGV[0];
my $path2 = $ARGV[1];

my @arr1 = read_file($path1);
my @arr2 = read_file($path2);

foreach(@arr1){
	if($_ ~~ @arr2){
		chomp $_;
		print "$_\n";
	}
}
