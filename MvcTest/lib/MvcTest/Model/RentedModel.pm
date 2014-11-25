package RentedModel;

sub new {
		my $class = shift;
		my $self = bless {
			'rental_id' 	=> shift,
			'film_id'		=> shift,
			'title' 		=> shift,
			'customer_id'	=> shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;