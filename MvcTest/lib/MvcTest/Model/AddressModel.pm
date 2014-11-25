package AddressModel;

sub new {
		my $class = shift;
		my $self = bless {
			'address_id'  => shift,
			'address' 	  => shift,
			'address2'    => shift,
			'district'	  => shift,
			'city_id'	  => shift,
			'postal_code' => shift,
			'phone'	 	  => shift,
			'last_update' => shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;