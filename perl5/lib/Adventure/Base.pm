use strict;
use warnings;
package Adventure::Base;
use Moo;
use Adventure;

sub init {
    my ($self, $key, $config) = @_;
    $self->key($key);
}

has key => (
    is  => 'rw',
    default => sub { undef },
);

sub install_plugin {
    my ($self, $key, $config, $options) = @_;
    if (ref $config eq 'HASH' && exists $config->{$options->{type}}) {
        if (ref $config->{$options->{type}} eq 'HASH') {
            $self->install_plugin_add_types($config->{$options->{type}}, $options);
        }
        else {
            die "$key ".$options->{type}." must be a hash";
        }
    }
}

sub install_plugin_add_types {
    my ($self, $config, $options) = @_;
    foreach my $key (keys %{$config}) {
        $self->install_plugin_add_type($key, $config->{$key}, $options);
    }
}

sub install_plugin_add_type {
    my ($self, $key, $config, $options) = @_;
    my $method = $options->{type};
    if (ref $config eq 'HASH') {
        if (exists $config->{code}) {
            my $module = 'Adventure::Module::'.Adventure->config->{namespace}.'::'.$options->{namespace}.'::'.$config->{code};
               eval "use $module;";
               if ($@) {
                   die $@;
               }
            $self->$method()->{$key} = sub { $module->main() };
        }
        elsif (exists $config->{description}) {
            $self->$method()->{$key} = sub {
                Adventure->player->announce($config);
                return;
            };
        }
        else {
            die $key.' has a bad config';
        }
    }
    else {
        $self->$method()->{$key} = sub {
            return $config;
        };
    }
}


# lembark said we could do this, but so far we haven't figured it out so we're manually creating the methods
# use Symbol qw(qualify_to_ref);
# foreach my $method (qw(location player item)) {
#     if (__PACKAGE__->can($method)) {
#         my $name = $method.'_object';
#         my $ref = qualify_to_ref $name;
#         my $sub = sub {
#             my $self = shift;
#             return Adventure->$method($self->$method);
#         };
#         *{$ref} = $sub;
#     }
# }


1;
