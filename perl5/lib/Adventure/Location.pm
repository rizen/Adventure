use strict;
use warnings;
package Adventure::Location;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Thing';
with 'Adventure::Role::Aliases';
with 'Adventure::Role::Properties';
with 'Adventure::Role::Actions';
with 'Adventure::Role::Items';

after init => sub {
    my ($self, $key, $config) = @_;
    warn "need to implement LOOK for $key. should that just be an action?";
    if (ref $config eq 'HASH' && exists $config->{actors}) {
        if (ref $config->{actors} eq 'ARRAY') {
            $self->add_actors($config->{actors});
        }
        else {
            die "$key actors must be an array";
        }
    }
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH' && exists $config->{exits}) {
        if (ref $config->{exits} eq 'HASH') {
            $self->add_exits($config->{exits});
        }
        else {
            die "$key exits must be a hash";
        }
    }
};

has exits => (
    is          => 'rw',
    default     => sub { {} },
);

sub add_exits {
    my ($self, $exits) = @_;
    foreach my $key (keys %{$exits}) {
        $self->add_exit($key, $exits->{$key});
    }
}

sub add_exit {
    my ($self, $key, $location) = @_;
    $self->exits->{$key} = $location;
    # need to add code plugins for location exits
}

has actors => (
    is          => 'rw',
    default     => sub { [] },
);

sub add_actors {
    my ($self, $actors) = @_;
    foreach my $actor (@{$actors}) {
        $self->add_actor($actor);
    }
}

sub add_actor {
    my ($self, $key) = @_;
    if (exists Adventure->actors->{$key}) {
        push @{$self->actors}, $key;
    }
    else {
        die "No such actor: $key";
    }
}

sub remove_actor {
    my ($self, $key) = @_;
    my @actors = @{$self->actors};
    @actors = grep {!/$key/} @actors;
    $self->actors(\@actors);
}

sub has_actor {
    my ($self, $key) = @_;
    return grep($key, @{$self->actors});
}

sub replace_actor {
    my ($self, $old, $new) = @_;
    if ($self->has_actor($old)) {
        $self->remove_actor($old);
        $self->add_actor($new);
    }
    else {
        die "actor $old does not exist in this location";
    }
}


1;
