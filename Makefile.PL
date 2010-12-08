#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

requires 'Plack' => '0.9951';
requires 'Moo' => '0.009003';
requires 'DBIx::Class::QueryLog' => '1.3.0';
test_requires 'HTTP::Request::Common';
test_requires 'strictures';
test_requires 'Test::More';
test_requires 'Test::Fatal';
test_requires 'Data::Dump';
test_requires 'Scalar::Util';

all_from 'lib/Plack/Middleware/DBIC/QueryLog.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

WriteAll;

