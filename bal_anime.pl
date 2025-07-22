#!/usr/bin/env perl
use strict;
use warnings;

my $focus = 0;
my @folders;
my %drive_info;
my %folder_info;
my @directories = (
	"/media/internal/plex/dr2/Anime",
	"/media/internal/plex/dr3/Anime",
	"/media/internal/plex/dr4/Anime",
);

sub initialize {
	foreach(0..scalar(@directories)-1){
		$drive_info{$_}{folders} = [];
		$drive_info{$_}{size} = 0;
	}
}

sub get_folders {
	my $path = shift;
	opendir(my $dh, $path) or die "Cannot open directory $path | $!";
	my @tmp_folders = readdir($dh);
	close $dh;
	
	foreach(@tmp_folders){
		next if $_ =~ /^\./g;
		push @folders, "$path/$_";
	}	
}

sub get_folder_info{
	my $file_path = shift;
	
	(my $folder_name = $file_path) =~ s/\/media\/internal\/plex\/dr\d\/Anime\///;
	my $size = (split(/\s+/, `du -d 0 "$file_path"`))[0];

	$folder_info{$folder_name}{size} = $size;
    $folder_info{$folder_name}{path} = $file_path;
}

sub get_lowest {
	my @sorted = sort { $drive_info{$a}{size} <=> $drive_info{$b}{size} }  keys %drive_info;
	return $sorted[0];
}

sub format_tb {
	my $size = shift;
	return sprintf("%.2fTb", ((($size/1024)/1024)/1024));
}

#### MAIN
# Initialize for the number of drives we will balance across
initialize();

# Get all folders from all drives we will be balancing
foreach(@directories){
	get_folders($_);
}

# Populate the hash with the file path and size
foreach(@folders){
	get_folder_info($_);
}

foreach(@folders){
	(my $folder_name = $_) =~ s/\/media\/internal\/plex\/dr\d\/Anime\///;  	
	$drive_info{$focus}{size} += $folder_info{$folder_name}{size};
	push(@{$drive_info{$focus}{folders}}, $folder_info{$folder_name}{path});

	# Add the target path to the folder hash
	my $target_drive_no = $focus+2;
	(my $target_drive = $_) =~ s/\d+/$target_drive_no/;
	$folder_info{$folder_name}{target} = $target_drive;

	$focus = get_lowest();
}

# Sort and present data
my @sorted_drive_info = sort { $drive_info{$a} <=> $drive_info{$b} }  keys %drive_info;
foreach my $drive (@sorted_drive_info) {
	my $num_folders = scalar(@{$drive_info{$drive}{folders}});
	my $size = format_tb($drive_info{$drive}{size});
	print "Expected results:\n$drive: Size: $size | # of folders: $num_folders\n\n";
}

# Move logic (Not tested to scale)
my @sorted_folders = sort { $folder_info{$a} <=> $folder_info{$b} } keys %folder_info;
foreach my $folder (@sorted_folders) {
	if ($folder_info{$folder}{target} eq $folder_info{$folder}{path}) {
		print "Skipping \"$folder_info{$folder}{path}\"\n\n";
		next; # Skip if the file is already where it should be
	}
	print "Moving \"$folder_info{$folder}{path}\"\n\t======>\"$folder_info{$folder}{target}\"\n\n";
#	`mv \"$folder_info{$folder}{path}\" \"$folder_info{$folder}{target}\"`;
}
