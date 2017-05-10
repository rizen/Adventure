use strict;
use warnings;
package Adventure::Player;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Thing';
with 'Adventure::Role::Aliases';
with 'Adventure::Role::Properties';
with 'Adventure::Role::Actions';
with 'Adventure::Role::Items';
use feature 'say';

after init => sub {
    my ($self, $key, $config) = @_;
    $self->add_aliases(['self','myself']);
    warn 'Need to implement EACH_TURN on Player';
    $self->location($config->{location});
};

has location => (
    is          => 'rw',
    default     => sub {undef},
);

sub location_object {
    my $self = shift;
    return Adventure->location($self->location);
}

has score => (
    is  => 'rw',
    default => 0,
);

sub announce {
    my ($self, $text) = @_;
    say $text;
}

sub kill {
    my $self = shift;
    $self->announce('Game Over');
    $self->display_score();
    exit;
}

sub display_score {
    my $self = shift;
    $self->announce('Score: '.$self->score);
}

1;
