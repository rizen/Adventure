use strict;
use warnings;
package Adventure;
use Moo;
use Adventure::Item;
use Adventure::Actor;
use Adventure::Location;
use Adventure::Player;
use YAML;
use experimental 'smartmatch';

use 5.010_000;

use mro     ();
use feature ();
use utf8    ();

sub import {
    warnings->import();
    warnings->unimport( qw/uninitialized/ );
    strict->import();
    feature->import( ':5.10' );
    mro::set_mro( scalar caller(), 'c3' );
    utf8->import();
}

my $_config = {};
sub config {
    return $_config;
}

sub name {
    return $_config->{name};
}

my $_locations = {};
sub locations {
    return $_locations;
}

sub location {
    my ($class, $id) = @_;
    return $_locations->{$id};
}

my $_items = {};
sub items {
    return $_items;
}

sub item {
    my ($class, $id) = @_;
    return $_items->{$id};
}

my $_actors = {};
sub actors {
    return $_actors;
}

sub actor {
    my ($class, $id) = @_;
    return $_actors->{$id};
}

my $_player = {};
sub player {
    return $_player;
}

sub init {
    my ($class, $config_path) = @_;
    die "You must specify a config file to init()" unless defined $config_path;
    $_config = YAML::LoadFile($config_path);
    $class->add_items($_config->{items});
    $class->add_actors($_config->{actors});
    $class->add_locations($_config->{locations});
    $class->add_player('player1', $_config->{player});
}

sub add_player {
    my ($class, $key, $config) = @_;
    $_player = Adventure::Player->new;
    $_player->init($key, $config);
}

sub add_locations {
    my ($class, $locations) = @_;
    foreach my $key (keys %{$locations}) {
        $class->add_location($key, $locations->{$key});
    }
}

sub add_location {
    my ($class, $key, $config) = @_;
    my $location = Adventure::Location->new;
    $location->init($key, $config);
    $class->locations->{$key} = $location;
}

sub get_location {
    my ($class, $key) = @_;
    return $class->locations->{$key};
}

sub add_items {
    my ($class, $items) = @_;
    foreach my $key (keys %{$items}) {
        $class->add_item($key, $items->{$key});
    }
}

sub add_item {
    my ($class, $key, $config) = @_;
    my $item = Adventure::Item->new;
    $item->init($key, $config);
    $class->items->{$key} = $item;
}

sub available_items {
    my $self = shift;
    return [keys %{$self->items} ];
}

sub item_exists {
    my ($self, $item) = @_;
    my $items = $self->available_items;
    if ($item ~~ $items) {
        return 1;
    }
    return 0;
}

sub get_item {
    my ($class, $key) = @_;
    return $class->items->{$key};
}

sub add_actors {
    my ($class, $actors) = @_;
    foreach my $key (keys %{$actors}) {
        $class->add_actor($key, $actors->{$key});
    }
}

sub add_actor {
    my ($class, $key, $config) = @_;
    my $actor = Adventure::Actor->new;
    $actor->init($key, $config);
    $class->actors->{$key} = $actor;
}

sub get_actor {
    my ($class, $key) = @_;
    return $class->actors->{$key};
}

sub welcome {
    return $_config->{welcome};
}




=head1 NAME

Adventure - Standardize what Perl configuration Adventure uses.


=head1 SYNOPSIS

 use Adventure;

=cut



1;
