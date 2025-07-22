#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my @output;
my @lines = `df | grep -E 'dr[2-4]'`;

foreach(@lines){
	my @exp_line = split(/\s+/, $_);
	my $line = $exp_line[3] . " | " . $exp_line[5] . "\n";
	chomp $line;
	push @output, $line;
}

#@output = sort @output;

foreach(sort @output){ print "$_\n"; }

#print "$output[2]\n";
