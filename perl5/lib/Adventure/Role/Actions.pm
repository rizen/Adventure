use strict;
use warnings;
package Adventure::Role::Actions;
use Moo::Role;
requires 'init';
use Adventure::Action;

has actions => (
    is          => 'rw',
    default     => sub { {} },
);

sub add_actions {
    my ($self, $actions) = @_;
    foreach my $key (keys %{$actions}) {
        $self->add_action($key, $actions->{$key});
    }
}

sub add_action {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH') {
        if (exists $config->{code}) {
            my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::Action::'.$config->{code};
            eval "use $module;";
            if ($@) {
                die $@;
            }
            $self->actions->{$key} = sub { $module->main() };
        }
        elsif (exists $config->{description}) {
            $self->actions->{$key} = sub {
                Adventure->player->announce($config);
            };
        }
        else {
            die $key.' has a bad config';
        }
    }
    else {
        $self->actions->{$key} = sub {
            Adventure->player->announce($config);
        };
    }
}

after init => sub {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH' && exists $config->{actions}) {
        if (ref $config->{actions} eq 'HASH') {
            $self->add_actions($config->{actions});
        }
        else {
            die "$key actions must be a hash";
        }
    }
};

sub available_actions {
    my $self = shift;
    return [keys %{$self->actions}];
}

sub use_action {
    my ($self, $action) = @_;
    my $available = $self->available_actions;
    if ($action ~~ $available) {
        $self->actions->{$action}->();
    }
    else {
        Adventure->player->announce('There is no action named '.$action.'.');
    }
}

1;
