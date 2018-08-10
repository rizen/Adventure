use strict;
use warnings;
package Adventure::Action;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Aliases';

sub init { $_[0]->SUPER::init }

sub perform {
    die "create your own damn perform method";
#    my $self = shift;
    #foreach my $action (@{$self->perform_actions}) {
#        $action->main();
    #}
}


1;
