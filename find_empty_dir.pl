use strict;
use warnings;
use File::Find;

my @empty_dirs;

find(
	{
		wanted => \&is_empty_dir,
	},
	(
		'/media/internal/plex/dr5/Music/',
	),
);

foreach(@empty_dirs){
	print "$_\n";	
	#`rmdir "$_"`;
}


sub is_empty_dir {
	my $dir_name = "$File::Find::name";
	if(-d $dir_name){
		opendir(my $dh, $dir_name) or next; # should never be hit
		if(scalar(grep { $_ ne "." && $_ ne ".." } readdir($dh)) == 0){
			push @empty_dirs, $dir_name;
		}
		closedir($dh);
	}
}

