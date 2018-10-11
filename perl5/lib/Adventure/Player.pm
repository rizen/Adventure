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
use Ouch;

sub init { $_[0]->SUPER::init }

has start_turn_events => (
    is          => 'rw',
    default     => sub { {} },
);

has end_turn_events => (
    is          => 'rw',
    default     => sub { {} },
);

after init => sub {
    my ($self, $key, $config) = @_;
    $self->add_aliases(['self','myself']);
    $self->install_plugin($key, $config, {
        type        => 'start_turn_events',
        namespace   => 'Turn',
    });
    $self->install_plugin($key, $config, {
        type        => 'end_turn_events',
        namespace   => 'Turn',
    });
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

has turns => (
    is  => 'rw',
    default => 0,
);

sub start_turn {
    my $self = shift;
    foreach my $key (keys %{$self->start_turn_events}) {
        $self->start_turn_events->{$key}->();
    }
}

sub end_turn {
    my $self = shift;
    foreach my $key (keys %{$self->end_turn_events}) {
        $self->end_turn_events->{$key}->();
    }
    $self->turns($self->turns + 1);
}

sub announce {
    my ($self, $text) = @_;
    say $text;
}

sub kill {
    my ($self, $message) = @_;
    if ($message) {
        $self->announce($message);
    }
    $self->announce('Game Over');
    $self->game_over;
}

sub game_over {
    my $self = shift;
    $self->display_score();
    ouch 'game over', 'Game Over';
}

sub display_score {
    my $self = shift;
    $self->announce('Score: '.$self->score);
    $self->announce('Turns: '.$self->turns);
}

sub display_inventory {
    my $self = shift;
    foreach my $key (keys %{$self->items}) {
        $self->announce($key . ': ' . $self->items->{$key} . '~'. Adventure->items->{$key}->name);
    }
}

1;
