use strictures 1;
use Test::More tests => 2;

BEGIN { use_ok 'Plack::Middleware::DBIC::QueryLog'; }

ok Plack::Middleware::DBIC::QueryLog::PSGI_ENV,
  'Got the expected constant';

