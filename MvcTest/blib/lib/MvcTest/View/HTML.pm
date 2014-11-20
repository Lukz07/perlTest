package MvcTest::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.html',
    render_die => 1,
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'layout.html',
);

=head1 NAME

MvcTest::View::HTML - TT View for MvcTest

=head1 DESCRIPTION

TT View for MvcTest.

=head1 SEE ALSO

L<MvcTest>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
