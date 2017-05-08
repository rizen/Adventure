use strict;
use warnings;
package Adventure::Role::Items;
use Moo::Role;
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
        $self->items->{$key} = $quantity;
    }
}

sub remove_item {
    my ($self, $key, $quantity) = @_;
    $quantity ||= 1;
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

sub has_item {
    my ($self, $key) = @_;
    return $self->items->{$key} || 0;
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
