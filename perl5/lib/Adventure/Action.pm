use strict;
use warnings;
package Adventure::Action;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Aliases';

sub perform {
    my $self = shift;
    foreach my $action (@{$self->perform_actions}) {
        $action->();
    }
}

has perform_actions => (
    is      => 'rw',
    default => sub { [] },
);

sub init {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH') {
        if (exists $config->{code}) {
            push @{$self->perform_actions}, sub {
                my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::Action::'.$config->{code};
                eval "use $module;";
                if ($@) {
                    die $@;
                }
                $module->main($config->{params});
            };
        }
        if (exists $config->{description}) {
            push @{$self->perform_actions}, sub {
                Adventure->player->announce($config->{description});
            };
        }
    }
    else {
        push @{$self->perform_actions}, sub {
            Adventure->player->announce($config);
        };
    }
}

sub add_exit {
    my ($self, $key, $location) = @_;
    if (ref $location eq 'HASH') {
        my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::Exit::'.$location->{code};
        eval "use $module;";
        if ($@) {
            die $@;
        }
        $self->exits->{$key} = sub { $module->main($location->{params}) };
    }
    else {
        $self->exits->{$key} = sub { return $location };
    }
}

1;
