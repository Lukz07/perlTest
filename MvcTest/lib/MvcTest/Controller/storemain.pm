package MvcTest::Controller::storemain;
use Moose;
use namespace::autoclean;
use MvcTest::DB::DBHelper;
use MvcTest::Helpers::MathHelper;
use MvcTest::Helpers::StringHelper;
use MvcTest::Model::StoreModel;

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
    $c->stash->{active} = StringHelper::getControllerName $c->controller();
	$c->forward('View::HTML');
}

sub add :Path('add'){
	my ( $self, $c ) = @_;	

    # connect to the database
  	my $dbh = DBHelper::connect();

	$c->forward('View::HTML');
	if ( $c->request->params->{staff_id} > 0 ){

	  	#my $staff_id 	= $c->request->params->{store_id};
	  	my $first_name 	= $c->request->params->{first_name};
	  	my $last_name 	= $c->request->params->{last_name};
	  	my $address_id 	= $c->request->params->{address_id};
	  	my $picture     = $c->request->params->{picture};
	  	my $email 		= $c->request->params->{email};
	  	my $store_id 	= $c->request->params->{store_id};
	  	my $active 		= $c->request->params->{active};
	  	my $username	= $c->request->params->{username};
	  	my $password	= $c->request->params->{password};
	  	my $last_update	= $c->request->params->{last_update};	  		

		# get a specific customer data by id
	  	my $sth = query( $dbh, qq{insert into staff(first_name, last_name, address_id, picture, email, store_id, active, username, password, last_update) 
		 					values('$first_name', '$last_name', '$address_id', '$picture', '$email', '$store_id', '$active', '$username', '$password', '$last_update')});

		$c->response->body('Guardardo correctamente<script>setTimeout( function(){ window.location = "/storemain";}, 3000);</script>');
	}else{

	}
}

sub page :Path('page') :Args(1){
	my ( $self, $c, $page ) = @_;

	$c->stash->{page} = $page;

    # connect to the database
  	my $dbh = DBHelper::connect();

  	my $page_size = 10;
  	my $start = $page_size*($page-1);

	# check the username and password in the database
  	my $sth = DBHelper::query($dbh, qq{SELECT * FROM staff order by staff_id LIMIT $start, $page_size } );

	my $json = {};

	while( my @staff = $sth->fetchrow_array() ){
		$json->{ $staff[0] } = new StoreModel( @staff );
	}

	$c->stash->{json_data} = $json;
	$c->stash->{json_status} = "OK";

	# calculo la cantidad total de páginas
  	$sth = DBHelper::query($dbh, qq{ SELECT count(*) as cantidad FROM staff } );

	my @num_rows = $sth->fetchrow_array();

	$c->stash->{total_pages} = MathHelper::round( $num_rows[0]/10 );	

	$c->forward('View::JSON');
}

sub editview :Path("editview") :Args(1){
	my ( $self, $c, $id ) = @_;
	$c->stash->{id} = $id;
	$c->forward('View::HTML');
}

sub editdata :Path("editdata") :Args(1){
	my ( $self, $c, $id ) = @_;

	if ( $id > 0 ){
		# editing
		$c->stash->{json_status} = "ok";
		if ( $c->request->input ){
			# posting
			$c->response->body("posting");
		}else{
			# viewing

		    # connect to the database
		  	my $dbh = DBHelper::connect();

			# get a specific staff data by id
		  	my $sth = DBHelper::query( $dbh, qq{SELECT * FROM staff where staff_id = $id } );

			my $json = {};

			$json->{staff} = new StoreModel( $sth->fetchrow_array() );

#			$sth = DBHelper::query( $dbh, qq{SELECT * FROM payment order by payment_id} );

#			my $index = 0;
#			while( my @payment = $sth->fetchrow_array() ){
#				$json->{payment}->{ $index++ } = new PaymentModel( @payment );
#			}

			$sth = DBHelper::query( $dbh, qq{SELECT s.staff_id, p.payment_id, p.amount, p.payment_date, p.last_update, customer_id
											 FROM sakila.staff s
											 JOIN sakila.payment p	on p.staff_id = s.staff_id
											 WHERE s.staff_id = $id
                                             order by staff_id} );

			my $index = 0;
			while( my @payment = $sth->fetchrow_array() ){
				$json->{payment}->{ $index++ } = new PaymentModel( @payment );
			}

			$c->stash->{json_data} = $json;
			$c->stash->{json_status} = "OK";
			$c->forward('View::JSON');
		}

	}else{
		# creating
		$c->stash->{json_status} = "error";
		$c->forward('View::HTML');
	}

	$c->forward('View::JSON');
}

sub editsave :Path("editsave") :Args(){
	my ( $self, $c ) = @_;

  	my $dbh = DBHelper::connect();

	  	my $staff_id 	= $c->request->params->{store_id};
	  	my $first_name 	= $c->request->params->{first_name};
	  	my $last_name 	= $c->request->params->{last_name};
	  	my $address_id 	= $c->request->params->{address_id};
	  	my $picture     = $c->request->params->{picture};
	  	my $email 		= $c->request->params->{email};
	  	my $store_id 	= $c->request->params->{store_id};
	  	my $active 		= $c->request->params->{active};
	  	my $username	= $c->request->params->{username};
	  	my $password	= $c->request->params->{password};
	  	my $last_update	= $c->request->params->{last_update};

 	my $sth = DBHelper::query( $dbh,"UPDATE staff 
								set staff_id    = '$staff_id', 
								first_name  = '$first_name',
								last_name	= '$last_name',
								address_id	= '$address_id',
								picture	    = '$picture',
								email		= '$email',
								store_id    = '$store_id',
								active      = '$active',
								username    = '$username',
								password    = '$password',
								last_update = '$last_update' 
								where staff_id = $staff_id");

	$c->forward('View::JSON');
}

# sub edit :Path('/edit') :Args(){
# 	my ( $self, $c, $id, $mode ) = @_;

# 	if ( !$mode ){
# 		$c->forward('View::HTML');
# 	}else{
# 		if ( $id > 0 ){
# 			# editing
# 			$c->stash->{json_status} = "ok";
# 			if ( $c->request->input ){
# 				# posting
# 				$c->response->body("posting");
# 			}else{
# 				# viewing
# 			    # connect to the database
# 			  	my $dbh = DBHelper::connect();

# 				# get data from
# 			  	my $sth = DBHelper::query( $dbh, qq{SELECT * FROM staff where staff_id = $id } );

# 				my $json = {};

# 				$json->{staff} = new StoreModel( $sth->fetchrow_array() );

# 				$c->stash->{json_data} = $json;
# 				$c->stash->{json_status} = "OK";
# 				$c->forward('View::JSON');
# 			}

# 		}else{
# 			# creating
# 			$c->stash->{json_status} = "error";
# 			$c->forward('View::HTML');
# 		}
# 	}
# }

sub delete :Path("delete") :Args(1) {
	my ( $self, $c, $id ) = @_;
	# connect to the database
	my $dbh = DBHelper::connect();
	# execute the delete query
 	my $sth = DBHelper::query( $dbh, "DELETE FROM staff WHERE staff_id = $id" );
 	$c->forward('View::HTML');
}

=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

# package StoreModel;

# sub new {
# 		my $class = shift;
# 		my $self = bless {
# 			'staff_id' => shift,
# 			'first_name' => shift,
# 			'last_name' => shift,
# 			'address_id' => shift,
# 			'picture' => shift,
# 			'email' => shift,
# 			'store_id' => shift,
# 			'active' => shift,
# 			'username' => shift,
# 			'password' => shift,
# 			'last_update' => shift,
# 			}, $class;
# 		return $self;
# }

# sub TO_JSON { return { %{ shift() } }; }

1;
