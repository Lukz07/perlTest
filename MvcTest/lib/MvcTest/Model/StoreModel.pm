package StoreModel;

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