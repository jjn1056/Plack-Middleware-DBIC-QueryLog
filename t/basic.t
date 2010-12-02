use strictures 1;
use Test::More;
use Test::Fatal;
use Plack::Middleware::DBIC::QueryLog;

ok my $app = sub { [200, ['Content-Type' => 'text/plain'], ['Hello!']] },
  'made a plack compatible application';

is(
  exception { $app = Plack::Middleware::DBIC::QueryLog->wrap($app) },
  undef,
  'No errors wrapping the application',
);



done_testing();
