use strictures 1;
use Test::More;
use Test::Fatal;
use Plack::Middleware::DBIC::QueryLog;

ok my $ql = Plack::Middleware::DBIC::QueryLog->new,
  'created test object';

is $ql->querylog_class, 'DBIx::Class::QueryLog',
  'correct default attribute';

is ref($ql->querylog_args), 'HASH',
  'correct default attribute';

isa_ok $ql->create_querylog, 'DBIx::Class::QueryLog',
  'correctly created querylog';

ok my $app = sub { [200, ['Content-Type' => 'text/plain'], ['Hello!']] },
  'made a plack compatible application';

is (
  exception { $app = Plack::Middleware::DBIC::QueryLog->wrap($app) },
  undef,
  'No errors wrapping the application',
);

is (
  +Plack::Middleware::DBIC::QueryLog::PSGI_KEY,
  'plack.middleware.dbic.querylog',
  'Got the expected PSGI_KEY constant',
);

done_testing();
