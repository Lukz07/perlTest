package MvcTest::Controller::account;
use Moose;
use namespace::autoclean;
use CGI qw(:standard);
use DBI;
use strict;
use warnings;
use JSON;

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

my $username     = $c->request->params->{username} || 'N/A';
my $password    = $c->request->params->{password} || 'N/A';

# read the CGI params
my $cgi = CGI->new;

# connect to the database
my $dbh = DBI->connect("DBI:mysql:database=perltest", "perltestUser", "Globant01") 
  or die $DBI::errstr;

# check the username and password in the database
my $statement = qq{SELECT id FROM Users WHERE username=? and password=?};
my $sth = $dbh->prepare($statement)
  or die $dbh->errstr;
$sth->execute($username, $password)
  or die $sth->errstr;
my ($userID) = $sth->fetchrow_array;

# create a JSON string according to the database result
my $message = ($userID) ? 
  qq{{"success" : "login is successful", "userid" : "$userID"}} : 
  qq{{"error" : "username or password is wrong"}};

my $error = ($userID) ? 0 : 1;

my $result = new Result($error, $message, $userID);

$c->log->debug($result->{'error'});
$c->log->debug($result->{'message'});
$c->log->debug($result->{'userid'});

$c->stash->{foo} = $result;
$c->forward('View::JSON');
}
=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

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