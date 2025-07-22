#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
use File::Slurp;

my $cwd = getcwd();
my $file = $ARGV[0];
my $path = "$cwd/$file";
my @lines = read_file($path);
my @yes;
my @no;

foreach(@lines){
	chomp $_;
	print "$_: [y/n]";
	my $input = get_input();
	if($input eq "y"){
		push(@yes, $_);
	} elsif($input eq "n"){
		push(@no, $_);
	}
}

foreach(@no){
	chomp $_;
	print "$_\n";
}

sub get_input{
	my $input;
	do{
		$input = <STDIN>;
		$input = lc($input);
		chomp $input;
	} while($input !~ /[y|n]/);
	return $input;
}
