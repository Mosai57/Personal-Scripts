use strict;
use warnings;
use DBM::Deep;

my $db_path = "/media/internal/dr6/databases/aniloc.db";
my $root = "/media/internal/";

opendir my $dh, $root or die "$0: opendir: $!";



