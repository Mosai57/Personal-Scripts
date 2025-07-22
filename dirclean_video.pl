#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp qw(read_file);
use Data::Dumper;

my $root_dir = "/media/internal/dr2/Anime/";

my @dirs = `find $root_dir -print`;
my @to_del;

sub is_folder_empty {
	my $dir = shift;
	opendir(my $dh, $dir) or die "Not a directory";
	return scalar(grep { $_ ne "." && $_ ne ".." } readdir($dh)) == 0;
}


foreach(@dirs){
	chomp($_);
	if(-d $_){
		next;
	}
	if($_ =~ /(\.mkv)|(\.mp4)$/ig){
		next;
	}
	if($_ =~ /\.\w+$/ig){
		next;
	}
	if(is_folder_empty($_)){
		print "REMOVING EMPTY DIR: $_\n";	
		push @to_del, $_;	
#		`rmdir \"$_\"`;
	}
}

print Dumper @to_del;
