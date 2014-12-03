package MvcTest::Controller::ticket;
use Moose;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(){
	my ( $self, $c ) = @_;
	
	$c->stash->{active} = StringHelper::getControllerName $c->controller();
	$c->forward('View::HTML');

}

1;