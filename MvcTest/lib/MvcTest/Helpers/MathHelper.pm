package MathHelper;

sub round { 
	my $var = shift; 
	if (intCheck($var - 0.5)) { 
		$var = $var + 0.1; 
	} 
	return sprintf("%.0f", $var); 
}

sub intCheck{ 
	my $num = shift; 
	return ($num =~ m/^\d+$/); 
}

1;