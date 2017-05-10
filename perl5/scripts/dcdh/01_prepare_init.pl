#!/usr/bin/env perl
use strict;
use warnings;

our $VERSION = '0.01';
use English;
use feature 'say';
use lib 'lib';
use Carp 'croak';

use DBIx::Class::DeploymentHandler;
use Config::JSON;

my $config = Config::JSON->new('scripts/dcdh/etc/config.json');

my $proj_schema = $config->get('ProjSchema');
eval "use $proj_schema;1"
    or croak "Error opening project schema $proj_schema $EVAL_ERROR";
# if perlcritic whines, migrate to Load::Module
# use Module::Load;
# load $proj_schema;

my $schema   = $proj_schema->connect( @{$config->get('db')} );
my $dbvendor = $config->get('dbvendor');

my $dh_opts = {
    schema           => $schema,
    databases        => [qq/$dbvendor/],
    script_directory => 'scripts/dcdh/upgrades',
    force_overwrite  => 1,
};

my $dh = DBIx::Class::DeploymentHandler->new($dh_opts);
say 'Preparing files to install a new database with version ' . $dh->to_version;
$dh->prepare_install();
say 'done';
