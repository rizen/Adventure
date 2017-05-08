use strict;
use warnings;
package Adventure::Role::Thing;
use Moo::Role;
requires 'init';
use Adventure::Action;

has name => (
    is          => 'rw',
    default     => sub {'No Name'},
);

has description => (
    is          => 'rw',
    default     => sub {'No Description'},
);

after init => sub {
    my ($self, $key, $config) = @_;
    $self->name($config->{name});
    $self->description($config->{description});
};

1;
