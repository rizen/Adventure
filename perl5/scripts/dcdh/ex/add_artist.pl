#!/usr/bin/env perl
use strict;
use warnings;

our $VERSION = '0.01';
use English use feature 'say';
use lib 'lib';
use Carp 'croak';

use Music::Schema;
use Config::JSON;
use Getopt::Long;

GetOptions(
    'name=s' => \my $name,
);

my $config = Config::JSON->new('scripts/dcdh/etc/config.json');

my $proj_schema = $config->get('ProjSchema');
eval "use $proj_schema;1"
    or croak "Error opening project schema $proj_schema $EVAL_ERROR";

my $schema = $proj_schema->connect( @{$config->get('db')} );

my $artists = $schema->resultset('Artist');

my $artist = $artists->new( {} );

$artist->name($name);

$artist->insert;

say sprintf '%s (%s) added', $artist->name, $artist->id;

