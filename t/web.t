use strictures 1;
use Test::More;
use Plack::Test;
use Plack::Middleware::DBIC::QueryLog;
use HTTP::Request::Common qw(GET);
use Data::Dump ();

ok my $app = sub {
  my $env = shift;
  my %tests = (
    key_exists => ($env->{Plack::Middleware::DBIC::QueryLog::PSGI_KEY} ? 1:0),
    isa => ref($env->{Plack::Middleware::DBIC::QueryLog::PSGI_KEY}),
  );

  [200, [], [Data::Dump::dump %tests]];
}, 'Got a plack application';

ok $app = Plack::Middleware::DBIC::QueryLog->wrap($app), 
  'Wrapped application with middleware';

test_psgi $app, sub {
  my $cb = shift;
  my %data = eval $cb->(GET '/')->content;

  ok $data{key_exists},
    'got PSGI_KEY';

  is $data{isa}, 'DBIx::Class::QueryLog',
    'Correct default querylog instance';
};

done_testing; 
