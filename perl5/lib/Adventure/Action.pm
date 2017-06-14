use strict;
use warnings;
package Adventure::Action;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Aliases';

sub perform {}

sub init {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH') {
        if (exists $config->{description}) {
            after perform => sub {
                Adventure->player->announce($config->{description});
            };
        }
        if (exists $config->{code}) {
            before perform => sub {
                my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::ActorAction::'.$config->{code};
                eval "use $module;";
                if ($@) {
                    die $@;
                }
                $module->main($config->{params});
            };
        }
    }
    else {
        after perform => sub {
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
