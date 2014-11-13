use strict;
use warnings;

use MvcTest;

my $app = MvcTest->apply_default_middlewares(MvcTest->psgi_app);
$app;

