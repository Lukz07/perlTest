package MvcTest::Controller::storemain;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MvcTest::Controller::storemain - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	$c->forward('View::HTML');

    #$c->response->body('Matched MvcTest::Controller::customer in customer.');
	#$c->redirect("customer/page", 1);
}

sub page :Path('page') :Args(1){
	my ( $self, $c, $page ) = @_;

	#my $page = $c->request->params->{page} ||1;

	$c->stash->{page} = $page;

    # connect to the database
	my $dbh = DBI->connect("DBI:mysql:database=sakila", "perltestUser", "Globant01") 
  		or die $DBI::errstr;

  	my $page_size = 10;
  	my $start = $page_size*($page-1);

	# check the username and password in the database
	my $statement = qq{SELECT * FROM staff order by staff_id LIMIT $start, $page_size };
	my $sth = $dbh->prepare($statement)
  		or die $dbh->errstr;
	$sth->execute()
  		or die $sth->errstr;

	my $json = {};

	while( my @staff = $sth->fetchrow_array() ){
		$json->{ $staff[0] } = new Result_query( @staff );
	}

	$c->stash->{json_data} = $json;
	$c->stash->{json_status} = "OK";

	$c->forward('View::JSON');
	#$c->forward('View::HTML');
}

sub edit :Path('edit') :Args(1){
	my ( $self, $c, $id ) = @_;
	#$c->response->body('customer->edit');

	if ( $id > 0 ){
		# editing
		$c->stash->{json_status} = "ok";
		if ( $c->request->input ){
			# posting
			$c->response->body("posting");
		}else{
			# viewing

		    # connect to the database
			my $dbh = DBI->connect("DBI:mysql:database=sakila", "perltestUser", "Globant01") 
		  		or die $DBI::errstr;

			# check the username and password in the database
			my $statement = qq{SELECT * FROM staff where staff_id = $id };
			my $sth = $dbh->prepare($statement)
		  		or die $dbh->errstr;
			$sth->execute()
		  		or die $sth->errstr;

			my $json = {};

			$json->{store} = new Result_query( $sth->fetchrow_array() );

			$c->stash->{json_data} = $json;
			$c->stash->{json_status} = "OK";
			$c->forward('View::JSON');
		}

	}else{
		# creating
		$c->stash->{json_status} = "error";
		$c->forward('View::HTML');
	}
	

}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

package Result_query;

sub new {
		my $class = shift;
		my $self = bless {
			'staff_id' => shift,
			'first_name' => shift,
			'last_name' => shift,
			'address_id' => shift,
			'picture' => shift,
			'email' => shift,
			'store_id' => shift,
			'active' => shift,
			'username' => shift,
			'password' => shift,
			'last_update' => shift,
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;
