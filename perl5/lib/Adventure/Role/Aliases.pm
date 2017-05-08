use strict;
use warnings;
package Adventure::Role::Aliases;
use Moo::Role;
requires 'init';

has aliases => (
    is          => 'rw',
    default     => sub { [] },
);

sub add_aliases {
    my ($self, $aliases) = @_;
    foreach my $key (@{$aliases}) {
        $self->add_alias($key);
    }
}

sub add_alias {
    my ($self, $alias) = @_;
    push @{$self->aliases}, $alias;
}

after init => sub {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH' && exists $config->{aliases}) {
        if (ref $config->{aliases} eq 'ARRAY') {
            $self->add_aliases($config->{aliases});
        }
        else {
            die "$key aliases must be an array";
        }
    }
    $self->add_alias($key);
};



1;
