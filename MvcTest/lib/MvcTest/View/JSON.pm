package MvcTest::View::JSON;
use Moose;
use namespace::autoclean;

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

__PACKAGE__->config(
        'View::JSON' => {
          allow_callback  => 1,    # defaults to 0
          callback_param  => 'cb', # defaults to 'callback'
          expose_stash    => [ qw(foo bar result) ], # defaults to everything
      }
    );

__PACKAGE__->meta->make_immutable;

1;
