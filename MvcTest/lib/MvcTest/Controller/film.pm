package MvcTest::Controller::film;
use Moose;
use namespace::autoclean;
use MvcTest::Model::FilmModel;
use MvcTest::Helpers::MathHelper;
use MvcTest::Helpers::StringHelper;
use MvcTest::DB::DBHelper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MvcTest::Controller::film - Catalyst Controller

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

	$c->stash->{page} = $page;

    # connect to the database
	my $dbh = DBHelper::connect();

  	my $page_size = 10;
  	my $start = $page_size*($page-1);

	# check the username and password in the database
	my $sth = DBHelper::query($dbh, qq{SELECT film_id, title, description, release_year, rating FROM film order by film_id LIMIT $start, $page_size } );

	my $json = {};

	while( my @customer = $sth->fetchrow_array() ){
		$json->{ $customer[0] } = new FilmModel( @customer );
	}

	$c->stash->{json_data} = $json;
	$c->stash->{json_status} = "OK";

	# calculo la cantidad total de páginas
  	$sth = DBHelper::query($dbh, qq{ SELECT count(*) as cantidad FROM film } );  	

	my @num_rows = $sth->fetchrow_array();
	$c->stash->{total_pages} = MathHelper::round( $num_rows[0]/10 );

	$c->forward('View::JSON');
}

=encoding utf8

=head1 AUTHOR

Martin Mendez,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
