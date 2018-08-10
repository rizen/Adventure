use strict;
use warnings;
package Adventure::Actor;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Thing';
with 'Adventure::Role::Aliases';
with 'Adventure::Role::Properties';
with 'Adventure::Role::Actions';
with 'Adventure::Role::Items';

sub init { $_[0]->SUPER::init }

after init => sub {
    my ($self, $key, $config) = @_;
    # commenting out for now. -sk.
     #warn "NEED to implement TALK for $key";
};

1;
