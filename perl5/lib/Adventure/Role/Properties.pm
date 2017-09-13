use strict;
use warnings;
package Adventure::Role::Properties;
use Moo::Role;
requires 'init';

has properties => (
    is          => 'rw',
    default     => sub { {} },
);

sub add_properties {
    my ($self, $properties) = @_;
    foreach my $key (keys %{$properties}) {
        $self->add_property($key, $properties->{$key});
    }
}

sub property { # alias of add_property
    my ($self, $name, $value) = @_;
    if ($value) {
        $self->add_property($name, $value);
    }
    $self->properties->{$name};
}

sub add_property {
    my ($self, $key, $value) = @_;
    $self->properties->{$key} = $value;
}

sub remove_property {
    my ($self, $key) = @_;
    delete $self->properties->{$key};
}

sub init {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH' && exists $config->{properties}) {
        if (ref $config->{properties} eq 'HASH') {
            $self->add_properties($config->{properties});
        }
        else {
            die "$key properties must be a hash";
        }
    }
}

1;
