package MvcTest::Controller::address;
use Moose;
use namespace::autoclean;
use MvcTest::Model::AddressModel;

BEGIN { extends 'Catalyst::Controller'; }

my $db_username = "perltestUser";
my $db_password = "123456";

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	$c->forward('View::HTML');
}

sub getCombo :Path{
    my ( $self, $c ) = @_;
	

    # connect to the database
	my $dbh = DBI->connect("DBI:mysql:database=sakila", $db_username, $db_password) 
  		or die $DBI::errstr;

	my $statement = qq{SELECT * FROM address order by address};
	my $sth = $dbh->prepare($statement)
  		or die $dbh->errstr;
	$sth->execute()
  		or die $sth->errstr;

	my $json = {};
	my $index = 0;
	while( my @address = $sth->fetchrow_array() ){
		#$json->{ $address[0] } = new AddressModel( @address );
		$json->{addresses}->{ $index++ } = new AddressModel( @address );
	}
	$c->stash->{json_data} = $json;
	$c->stash->{json_status} = "OK";
	$c->forward('View::JSON');
}