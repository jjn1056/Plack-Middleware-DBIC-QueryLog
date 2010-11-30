#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

requires 'Plack' => '0.9951';
requires 'Moo' => '0.009002';
requires 'DBIx::Class::QueryLog' => '1.3.0';
test_requires 'Test::More';
test_requires 'Data::Dump';

all_from 'lib/Plack/Middleware/QueryLog.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

WriteAll;

