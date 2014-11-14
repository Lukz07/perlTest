use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MvcTest';
use MvcTest::Controller::home;

ok( request('/home')->is_success, 'Request should succeed' );
done_testing();
