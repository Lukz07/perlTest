package Result;

sub new {
		my $class = shift;
		my $self = bless {
			'error' => shift,
			'message' => shift,
			'userid' => shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;