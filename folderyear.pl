#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

my $directory = $ARGV[0];

opendir my $dh, $directory, or die "Cannot open directory $directory $!";
my @folders = readdir($dh);
close $dh;

print "Directory read. Press enter to begin.";
<>;
<>;

my $ctr = 1;
my $count = scalar(@folders);

#@folders = sort @folders;

foreach(sort @folders){
	if ($_ =~ /^\.+/){
		$ctr++;
		next;
	}
	if ($_ =~ /\(\d{4}\)$/){
		$ctr++;
		next;
	}
	
	print "($ctr/$count)\n";
	print $_ . "\n";
	print "Year: ";
	my $year = <>;

	chomp $year;

	print "$directory/$_\n\t=> $directory/$_ ($year)\n\n";
	`mv "$directory/$_" "$directory/$_ ($year)"`;
	$ctr++;
}
