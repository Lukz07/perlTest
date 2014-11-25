package FilmModel;

sub new {
		my $class = shift;
		my $self = bless {
			'film_id' => shift,
			'title' 	  => shift,
			'description'  => shift,
			'release_year'	  => shift,
			'rating'		  => shift
			}, $class;
		return $self;
}

sub TO_JSON { return { %{ shift() } }; }

1;