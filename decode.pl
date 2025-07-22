use strict;
use warnings;
use File::Slurp;

my @words = read_file('3letters.txt');
my @matches;

print "Entering loop\n";

foreach(@words){
	my @lets = split('', $_);
	if($lets[0] eq $lets[1]){
		print "Found\n";
		push(@matches, $_);
	}
}

print @matches;
