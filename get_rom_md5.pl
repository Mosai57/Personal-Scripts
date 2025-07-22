use strict;
use warnings;
use File::Find;
use Cwd;
my $cwd = getcwd;

find(
	{
		wanted => \&get_md5,
	},
	(
		'/media/internal/dr6/Emulators/Roms',
	),
);

sub get_md5 {
	my $raw_val = `md5sum "$File::Find::name"`;
	if($raw_val =~ /^[\w|\d]{32}\s+/ig){
		my ($md5, $path) = split(/\s{2}/, $raw_val);
		chomp $path;
		print "$md5 -> $path\n";
		system("/usr/bin/perl", "$cwd/roms/add_todb.pl", $md5, "\"$path\"");
	}
}
exit;
