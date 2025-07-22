use strict;
use warnings;
use Cwd;

my $cur_dir = getcwd;
opendir(BIN, $cur_dir) or die "Can't open $cur_dir: $!";
my @songs = grep(/\.mp3$/, readdir BIN);

foreach(@songs){
	$_ =~ /^(\d+). (.*).mp3/;

	my $track = $1;
#	$track =~ s/^0+(?=[0-9])//;
	my $title = $2;

	my $formatted_track = sprintf("%d", $track);

	`id3v2 -t "$title" -T $formatted_track "$_"`;


#	print "$cur_dir/$_\n\tTrack: $formatted_track\n\tTitle: $title\n";
}
