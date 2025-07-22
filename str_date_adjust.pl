use strict;
use warnings;
use File::Slurp;

my $dir = $ARGV[0];
opendir(my $dh, $dir) or die "Cannot open dir $dir: $!";
my @files = grep { /\.mp4$/ } readdir($dh);
closedir $dh;

foreach(@files){
	if($_ =~ /(\(.*\))/){
		


	print $_ . "\n";
}
