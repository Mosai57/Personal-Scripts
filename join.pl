#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;

my @times = read_file("time.txt");
chomp(@times);
print join " + ", @times;
