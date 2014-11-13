#!C:\Perl64\bin


use CGI;
use DBI;
use strict;
use warnings;

# read the CGI params
my $cgi = CGI->new;
# my $username = $cgi->param("username");
# my $password = $cgi->param("password");

my $username = "username1";
my $password = "password1";

# connect to the database
my $dbh = DBI->connect("DBI:mysql:database=test", "lucas", "lucas") 
  or die $DBI::errstr;

# check the username and password in the database
my $statement = qq{SELECT id FROM mydb WHERE username=? and password=?};
my $sth = $dbh->prepare($statement)
  or die $dbh->errstr;
$sth->execute($username, $password)
  or die $sth->errstr;
my ($userID) = $sth->fetchrow_array;

# create a JSON string according to the database result
my $json = ($userID) ? 
  qq{{"success" : "login is successful", "userid" : "$userID"}} : 
  qq{{"error" : "username or password is wrong"}};

# return JSON string
print $cgi->header(-type => "application/json", -charset => "utf-8");
print $json;