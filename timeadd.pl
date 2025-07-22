#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp;
use Cwd;

# For disassembly
my %time_conv = (
	"s"	=>	1,		# Second
	"m"	=>	60,		# Minute
	"h"	=>	3600,	# Hour
	"d"	=>	86400,	# Day
	"w"	=>	604800,	# Week
);

# For reassembly
my @label_ref = ( "w", "d", "h", "m", "s" );
my @times_ref = ( 604800, 86400, 3600, 60, 1 );

my $total = 0;

#####################################################

#my $in = <>;
#chomp $in;

#my 
#my @inputs = split(" ", $in);

my $file = $ARGV[0];
my $cwd = getcwd();
my @inputs = read_file("$cwd/$file");

foreach(@inputs){
	$total += conv_time_to_base($_);
}
my $conv_total = conv_time_to_str($total);

print $conv_total . "\n";

######################################################
sub conv_time_to_base {
	my $str = shift;
	my $total = 0;
	my $cur_num = "";

	my @time_arr = split("", $str);

	foreach(@time_arr){
		if($_ =~ /\d/){
			$cur_num .= $_;
		} elsif ($_ =~ /\w/){
			$total += ($cur_num * $time_conv{$_});
			$cur_num = "";
		}
	}

	return $total;
}

sub conv_time_to_str {
	my $sum = shift;
	my $str = "";
	my $ctr = 0;

	foreach(@times_ref){
		if ( $sum < $_ ){
			$ctr++;
			next;
		}
		$str .= int($sum / $_);
		$str .= $label_ref[$ctr];
		$sum = $sum % $_;
		$ctr++;
	}
	return $str;
}
