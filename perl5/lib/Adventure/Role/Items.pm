use strict;
use warnings;
package Adventure::Role::Items;
use Moo::Role;
use Try::Tiny;
requires 'init';

has items => (
    is          => 'rw',
    default     => sub { {} },
);

sub add_items {
    my ($self, $items) = @_;
    foreach my $key (keys %{$items}) {
        $self->add_item($key, $items->{$key});
    }
}

sub add_item {
    my ($self, $key, $quantity) = @_;
    $quantity ||= 1;
    if (exists $self->items->{$key}) {
        $self->items->{$key} += $quantity;
    }
    else {
        if (exists Adventure->items->{$key}) {
            $self->items->{$key} = $quantity;
        }
        else {
            die "No such item exists: $key";
        }
    }
}

sub remove_item {
    my ($self, $key, $quantity) = @_;
    $quantity ||= 1;
    if (exists $self->items->{$key} && defined $self->items->{$key}) {
        if ($self->items->{$key} == $quantity) {
            delete $self->items->{$key};
        }
        elsif ($self->items->{$key} < $quantity) {
            die "Not enough $key";
        }
        else {
            $self->items->{$key} -= $quantity;
        }
    }
    else {
        die "$key does not exist";
    }
}

sub has_item {
    my ($self, $key) = @_;
    return $self->items->{$key} || 0;
}

sub put_item {
    my ($self, $item_key, $object, $quantity) = @_;
    $quantity ||= 1;
    $self->remove_item($item_key, $quantity);
    try {
        $object->add_item($item_key, $quantity);
    }
    catch {
        $self->add_item($item_key, $quantity);
        die $_;
    }
}

after init => sub {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH' && exists $config->{items}) {
        if (ref $config->{items} eq 'HASH') {
            $self->add_items($config->{items});
        }
        else {
            die "$key items must be a hash";
        }
    }
};

1;
