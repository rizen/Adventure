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
    warn "need to implement ACTORS for $key.";
    warn "need to implement EXITS for $key.";
};

1;
