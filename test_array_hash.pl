use strict;
use warnings;
use Data::Dumper;

my %test_hash = (
	array	=> 	['item1', 'item2', 'item3'],
	scalar	=>	7,
	hash	=> {
				name => "mini innie hash",
				age => 1,
			},
);

print "DUMPER RESULTS:\n";
print Dumper %test_hash;

print "The scalar in the hash is: " . $test_hash{'scalar'} . "\n\n";

print "The array in the hash contains:\n";
foreach(@{$test_hash{'array'}}){
	print "--> $_\n";
}

print "Adding elements to array\n";
push @{ $test_hash{'array'} }, "new1", "new2";

print "The new array contents are:\n";
foreach(@{$test_hash{'array'}}){
	print "--> $_\n";
}
print "The second element [1] in the array is: " . @{$test_hash{'array'}}[1] . "\n";


print "The internal hash's name is: " . 
	$test_hash{'hash'}{'name'}  .
	", and it is " . $test_hash{'hash'}{'age'} . " second old.\n\n";

print "Adding a new key/value to the hash\n";
$test_hash{'newval'} = "this is a new value";
print "The new value added is: " . $test_hash{'newval'} . "\n\n";

print "DUMPER RESULTS:\n";
print Dumper %test_hash;
