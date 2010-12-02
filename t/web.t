use strictures 1;
use Test::More;
use Plack::Test;
use Plack::Middleware::DBIC::QueryLog;
use HTTP::Request::Common qw(GET);
use Data::Dump ();

ok my $app = sub {
    my $env = shift;
    my $querylog = $env->{'plack.middleware.dbic.querylog'};
    my $checks = {
        isa => $querylog->isa('DBIx::Class::QueryLog') ? 1:0,
    };
    return [
        200, ['Content-Type' => 'application/perl'],
        [Data::Dump::dump { isa => $checks }],
    ];
}, 'Got a plack application';

my %opts = (
    ## Do here the constructor args
);

ok $app = Plack::Middleware::DBIC::QueryLog->wrap($app, %opts), 
  'Wrapped application with middleware';

test_psgi $app, sub {

    my $cb = shift;
    my $res = $cb->(GET '/');
    my $checks = eval { $res->content };

    use Data::Dump 'dump';
    warn dump $checks;

};

done_testing; 
