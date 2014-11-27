package PaymentModel;

sub new {
		my $class = shift;
		my $self = bless {
			'payment_id'  => shift,
			'customer_id' => shift,
			'staff_id'    => shift,
			'rental_id'	  => shift,
			'amount'	  => shift,
			'payment_date' => shift,
			'last_update' => shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;