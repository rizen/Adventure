#!/usr/bin/env perl
use strict;
use warnings;

our $VERSION = '0.01';
use English;
use feature 'say';
use lib 'lib';
use Carp 'croak';

use Music::Schema;
use Config::JSON;
use Getopt::Long;

GetOptions(
    'name=s'  => \my $name,
    'title=s' => \my $title,
    'year=i'  => \my $year,
);

my $config = Config::JSON->new('scripts/dcdh/etc/config.json');

my $proj_schema = $config->get('ProjSchema');
eval "use $proj_schema;1"
    or croak "Error opening project schema $proj_schema $EVAL_ERROR";

my $schema = $proj_schema->connect( @{$config->get('db')} );

my $artists = $schema->resultset('Artist');
my $albums  = $schema->resultset('Album');

my $artist = $artists->search( {name => $name}, {rows => 1} )->single;

if ( defined $artist ) {
    my $album = $albums->new( {} );
    $album->artistid( $artist->artistid );
    $album->title($title);
    $album->year($year);
    $album->insert;
    say sprintf '%s (%s) added', $album->title, $album->id;
}
else {
    say 'artist not found';
}

