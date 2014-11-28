package MvcTest::Controller::inventory;
use Moose;
use namespace::autoclean;
use MvcTest::Helpers::StringHelper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MvcTest::Controller::home - Catalyst Controller

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

sub page :Path('page') :Args(1){
	my ( $self, $c, $page ) = @_;

	#my $page = $c->request->params->{page} ||1;

	$c->stash->{page} = $page;

    # connect to the database
	#my $dbh = DBI->connect("DBI:mysql:database=sakila", $db_username, $db_password) 
  	#	or die $DBI::errstr;
  	my $dbh = DBHelper::connect();

  	my $page_size = 10;
  	my $start = $page_size*($page-1);

	# check the username and password in the database
	#my $statement = qq{SELECT * FROM customer order by customer_id LIMIT $start, $page_size };
	#my $sth = $dbh->prepare($statement)
  	#	or die $dbh->errstr;
	#$sth->execute()
  	#	or die $sth->errstr;
  	my $sth = DBHelper::query($dbh, qq{	SELECT 	f.film_id, 
  												f.title,
  												count(i.film_id) as total_quantity,
  												count(i.film_id) - sum( isnull(r.return_date) ) as available
  										FROM inventory i
  										JOIN film f 	on f.film_id = i.film_id
  										JOIN store s 	on s.store_id = i.store_id
  										JOIN rental r 	on r.inventory_id = i.inventory_id
  										GROUP BY i.film_id
  										ORDER BY f.title 
  										LIMIT $start, $page_size } );

	my $json = {};
	my @inventories;
	while( my @inventory = $sth->fetchrow_array() ){
		push( @inventories, new InventoryModel( @inventory ) );
	}
	$json->{inventories} = \@inventories;

	$c->stash->{json_data} = $json;
	$c->stash->{json_status} = "OK";

	# calculo la cantidad total de páginas
	#$statement = qq{SELECT count(*) as cantidad FROM customer };
	#$sth = $dbh->prepare($statement)
  	#	or die $dbh->errstr;
	#$sth->execute()
  	#	or die $sth->errstr;
  	$sth = DBHelper::query($dbh, qq{ SELECT count(*) as cantidad FROM customer } );  	

	my @num_rows = $sth->fetchrow_array();

	$c->stash->{total_pages} = MathHelper::round( $num_rows[0]/10 );

	$c->forward('View::JSON');
	#$c->forward('View::HTML');
	
}

sub editview :Path("editview") :Args(1){
	my ( $self, $c, $id ) = @_;
	$c->stash->{id} = $id;
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

1;
