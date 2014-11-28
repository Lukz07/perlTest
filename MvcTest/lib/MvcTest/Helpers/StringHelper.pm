package StringHelper;

sub getControllerName{ 
	my $package = shift; 
	my $firstIndex = index $package, '::';
	my $secondIndex = index $package, '::', $firstIndex+1;
	my $thirdIndex = index $package, "=", $secondIndex;
	return substr $package, $secondIndex +2, $thirdIndex - $secondIndex-2;
}

1;