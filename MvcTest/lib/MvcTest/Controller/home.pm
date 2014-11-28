package MvcTest::Controller::home;
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
    $c->stash(template => 'home.html');
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
