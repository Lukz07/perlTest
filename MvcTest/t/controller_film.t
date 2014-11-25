use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MvcTest';
use MvcTest::Controller::film;

ok( request('/film')->is_success, 'Request should succeed' );
done_testing();
