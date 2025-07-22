use strict;
use warnings;
use Cwd qw(cwd);

#my $dir = cwd;
opendir my $dir, cwd or die "Cannot open dir $!";
my @files = readdir $dir;
closedir $dir;

foreach(@files){
	next if $_ =~ /^\.{1,2}$/i;

	print "Unzipping $_\n";

	`unzip \"$_\"`;
}
