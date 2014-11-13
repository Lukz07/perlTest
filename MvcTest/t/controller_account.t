use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MvcTest';
use MvcTest::Controller::account;

ok( request('/account')->is_success, 'Request should succeed' );
done_testing();
