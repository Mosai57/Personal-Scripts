#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
use File::Slurp;

my $dir = getcwd();
opendir(my $dh, $dir) || die "Can't opendir $dir $!";
my @epubs = grep { /\.epub$/ } readdir($dh);
closedir $dh;

#my @filenames = read_file($filename);
#s/\n// for @filenames;
@epubs = sort {$a cmp $b} @epubs;
s/\n// for @epubs;
s/\r// for @epubs;

foreach(@epubs){
	my $filename = $_;
	s/\.epub$// for $filename;
	my ($book, $author) = split(' - ', $filename);
#	print "Book name: $book\nAuthor: $author\n========\n";	
	`mkdir \"$book\"`;
	`mkdir \"$book/$author\"`;
	`mv \"$_\" \"./$book/$author\"`;
#	print "mv \"$_\" \"$book/$author\"\n";
}
