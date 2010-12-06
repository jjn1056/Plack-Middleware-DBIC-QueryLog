use strictures 1;
use Test::More;
use Plack::Test;
use Plack::Middleware::DBIC::QueryLog;
use HTTP::Request::Common qw(GET);

ok my $app = sub {
    my $env = shift;
    [200, [], ['ok']];
}, 'Got a plack application';

ok $app = Plack::Middleware::DBIC::QueryLog->wrap($app), 
  'Wrapped application with middleware';

test_psgi $app, sub {
  my $cb = shift;
  my $res = $cb->(GET '/');

  use Data::Dump 'dump';
  warn dump $res->content;
};

done_testing; 
