use strictures 1;
use Test::More;
use Test::Fatal;
use Plack::Middleware::DBIC::QueryLog;

ok my $app = sub {},
  'made an app';

is(
  exception { $app = Plack::Middleware::DBIC::QueryLog->wrap($app) },
  undef,
  'No errors wrapping an app',
);



done_testing();
