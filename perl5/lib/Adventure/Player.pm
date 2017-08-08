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

has each_start_turns => (
    is          => 'rw',
    default     => sub { {} },
);

has each_end_turns => (
    is          => 'rw',
    default     => sub { {} },
);
#
# sub add_each_end_turns {
#     my ($self, $turn) = @_;
#     foreach my $key (keys %{$turn}) {
#         $self->add_each_end_turn($key, $turn->{$key});
#     }
# }
#
# sub add_each_end_turn {
#     my ($self, $key, $config) = @_;
#     if (ref $config eq 'HASH') {
#         if (exists $config->{code}) {
#             my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::Turn::'.$config->{code};
# 	        Adventure::Adv_Add_Plugin( $module );
#             $self->each_end_turns->{$key} = sub { $module->main() };
#         }
#         elsif (exists $config->{description}) {
#             $self->each_end_turns->{$key} = sub {
#                 Adventure->player->announce($config);
#             };
#         }
#         else {
#             die $key.' has a bad config';
#         }
#     }
#     else {
#         $self->each_end_turns->{$key} = sub {
#             Adventure->player->announce($config);
#         };
#     }
# }

after init => sub {
    my ($self, $key, $config) = @_;
    $self->add_aliases(['self','myself']);
    # if (ref $config eq 'HASH' && exists $config->{each_start_turn}) {
    #     if (ref $config->{each_start_turn} eq 'HASH') {
    #         $self->add_each_start_turns($config->{each_start_turn});
    #     }
    #     else {
    #         die "$key each_start_turn must be a hash";
    #     }
    # }
    # if (ref $config eq 'HASH' && exists $config->{each_end_turn}) {
    #     if (ref $config->{each_end_turn} eq 'HASH') {
    #         $self->add_each_end_turns($config->{each_end_turn});
    #     }
    #     else {
    #         die "$key each_end_turn must be a hash";
    #     }
    # }
    $self->install_plugin($key, $config, {
        type        => 'each_start_turns',
        namespace   => 'Turn',
    });
    $self->install_plugin($key, $config, {
        type        => 'each_end_turns',
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
    foreach my $key (keys %{$self->each_start_turns}) {
        $self->each_start_turns->{$key}->();
    }
}

sub end_turn {
    my $self = shift;
    foreach my $key (keys %{$self->each_end_turns}) {
        $self->each_end_turns->{$key}->();
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
    $self->display_score();
    exit;
}

sub display_score {
    my $self = shift;
    $self->announce('Score: '.$self->score);
    $self->announce('Turns: '.$self->turns);
}

1;
