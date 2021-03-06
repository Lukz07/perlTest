package MvcTest::View::JSON;
use Moose;
use namespace::autoclean;
use JSON;

extends 'Catalyst::View::JSON';

=head1 NAME

MvcTest::View::JSON - Catalyst View

=head1 DESCRIPTION

Catalyst View.


=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub encode_json {
      my($self, $c, $data) = @_;
      to_json($data, {allow_blessed=>1,convert_blessed=>1});
}

__PACKAGE__->meta->make_immutable( "inline_constructor"=> 0);

1;
