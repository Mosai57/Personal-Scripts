#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp qw(read_file);

my @links = read_file($ARGV[0]);

foreach(@links){
	`wget $_`;
}

print "done!\n";
