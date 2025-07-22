#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $target = $ARGV[0];
my @files;

opendir(my $dh, $target) or die "Cannot open: $target $!";
@files = readdir($dh);
close $dh;

my @year;
my @no_year;

print "Directory read: Please press enter";
<>;
<>;

foreach(@files){
	if($_ =~ /\.{1,2}$/){
		next;
	}

	if($_ =~ /\(\d{4}\)\.\w{3,4}$/ig){
		push @year, $_;
	} else {
		push @no_year, $_;
	}
}

@no_year = sort(@no_year);
print scalar(@no_year) . " remaining\n";

my $ctr = 1;
my $count = scalar(@no_year);

foreach(@no_year){
	print "($ctr/$count)\n";
	print "$_: ";
	
	my $year = <>;
	chomp $year;

	#my @exp_line = split(/\./, $_);
	#my $new_file = $exp_line[0] . " ($year)." . $exp_line[1];
	
	my $filename = $_;
	$_ =~ m/(\.\w{3,4})$/;
	my $ext = $1;
	print $ext . "\n";
	$filename =~ s/$ext//;
	$filename .= " ($year)". lc($ext);
	print $filename . "\n"; 
	
	print "Moving: \"$target$_\"\n\t=> \"$target$filename\"\n";
	`mv \"$target$_\" \"$target$filename\"`;
	$ctr++;
}


#print Dumper @year;
#print Dumper @no_year;
