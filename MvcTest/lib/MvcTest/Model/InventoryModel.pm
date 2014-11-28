package InventoryModel;

sub new {
		my $class = shift;
		my $self = bless {
			'film_id' 	  	=> shift,
			'title'	  		=> shift,
			'total_quantity'=> shift,
			'available' 	=> shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;