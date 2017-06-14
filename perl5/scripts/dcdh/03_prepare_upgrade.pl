#!/usr/bin/env perl
use strict;
use warnings;

our $VERSION = '0.01';
our English;
use feature 'say';
use lib 'lib';
use Carp 'croak';

use DBIx::Class::DeploymentHandler;
use Config::JSON;

my $config = Config::JSON->new('scripts/dcdh/etc/config.json');

my $proj_schema = $config->get('ProjSchema');
eval "use $proj_schema;1"
    or croak "Error opening project schema $proj_schema $EVAL_ERROR";

my $schema   = $proj_schema->connect( @{$config->get('db')} );
my $dbvendor = $config->get('dbvendor');

my $dh_opts = {
    schema              => $schema,
    databases           => [qq/$dbvendor/],
    sql_translator_args => {add_drop_table => 0},
    script_directory    => 'scripts/dcdh/upgrades',
    force_overwrite     => 1,
};

my $dh           = DBIx::Class::DeploymentHandler->new($dh_opts);
my $code_version = $schema->schema_version;
say "Prepare upgrade information for $code_version";
if ( $code_version > 1 ) {
    say "\tgenerating install script";
    $dh->prepare_install();
    say "\tgenerating upgrade script";
    my $previous_version = $code_version - 1;
    $dh->prepare_upgrade(
        {
            from_version => $previous_version,
            to_version   => $code_version,
            version_set  => [$previous_version, $code_version],
        }
    );

    say "\tgenerating downgrade script";
    $dh->prepare_downgrade(
        {
            from_version => $code_version,
            to_version   => $previous_version,
            version_set  => [$code_version, $previous_version],
        }
    );

}
say 'done';

