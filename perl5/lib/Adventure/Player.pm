use strict;
use warnings;
package Adventure::Player;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Thing';
with 'Adventure::Role::Aliases';
with 'Adventure::Role::Properties';
with 'Adventure::Role::Actions';
with 'Adventure::Role::Items';
use feature 'say';

after init => sub {
    my ($self, $key, $config) = @_;
    $self->add_aliases(['self','myself']);
    warn 'Need to implement EACH_TURN on Player';
    warn 'Need to implement LOCATION on Player';
};

sub announce {
    my ($self, $text) = @_;
    say $text;
}


1;
