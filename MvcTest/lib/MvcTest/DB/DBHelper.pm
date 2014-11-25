package DBHelper;

my $db_username = "perltestUser";
my $db_password = "123456";

sub connect{
	return DBI->connect("DBI:mysql:database=sakila", $db_username, $db_password) 
}

sub query{
	my $dbh = shift;
	my $statement = shift;
	my $sth = $dbh->prepare($statement)
	  		or die $dbh->errstr;
	$sth->execute(@_)
	  		or die $sth->errstr;
	return $sth;
}

1;