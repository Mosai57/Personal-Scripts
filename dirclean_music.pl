#!/usr/bin/env perl
use strict;
use warnings;
use File::Slurp qw(read_file);
use Data::Dumper;

my $root_dir = "/media/internal/dr5/Music/";

my @dirs = `find $root_dir -print`;

sub is_folder_empty {
	my $dir = shift;
	opendir(my $dh, $dir) or die "Not a directory";
	return scalar(grep { $_ ne "." && $_ ne ".." } readdir($dh)) == 0;
}


foreach(@dirs){
	chomp($_);
	#if(-d $_){
	#	next;
	#}
	if($_ =~ /(\.mp3)|(\.flac)|(\.m4a)|(\.wav)|(\.ogg)|(\.wma)$/ig){
		next;
	}
	if($_ =~ /\.\w+$/ig){
		next;
	}
	if(is_folder_empty($_)){
		print "REMOVING EMPTY DIR: $_\n";	
#		`rmdir \"$_\"`;
	}
}

#print Dumper @dirs;
