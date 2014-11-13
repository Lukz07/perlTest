package MvcTest::Controller::account;
use Moose;
use namespace::autoclean;
use CGI;
use DBI;
use strict;
use warnings;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MvcTest::Controller::account - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
 
    $c->stash(template => 'account/login.html');
}


sub login :Local :Args(0) {
	my ($self, $c) = @_;

my $username     = $c->request->params->{username}     || 'N/A';
my $password    = $c->request->params->{password}    || 'N/A';

$c->stash(username => $username, password => $password, template => 'home.html');

# # read the CGI params
# my $cgi = CGI->new;
# # my $username = $cgi->param("username");
# # my $password = $cgi->param("password");

# # connect to the database
# my $dbh = DBI->connect("DBI:mysql:database=test", "lucas", "lucas") 
#   or die $DBI::errstr;

# # check the username and password in the database
# my $statement = qq{SELECT id FROM mydb WHERE username=? and password=?};
# my $sth = $dbh->prepare($statement)
#   or die $dbh->errstr;
# $sth->execute($username, $password)
#   or die $sth->errstr;
# my ($userID) = $sth->fetchrow_array;

# # create a JSON string according to the database result
# my $json = ($userID) ? 
#   qq{{"success" : "login is successful", "userid" : "$userID"}} : 
#   qq{{"error" : "username or password is wrong"}};
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
