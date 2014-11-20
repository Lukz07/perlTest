use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MvcTest';
use MvcTest::Controller::storemain;

ok( request('/storemain')->is_success, 'Request should succeed' );
done_testing();
