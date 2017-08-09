use strict;
use warnings;
package Adventure::Role::Actions;
use Moo::Role;
requires 'init';
use Adventure::Action;
use experimental 'smartmatch';

has actions => (
    is          => 'rw',
    default     => sub { {} },
);

after init => sub {
    my ($self, $key, $config) = @_;
    $self->install_plugin($key, $config, {
        type        => 'actions',
        namespace   => 'Action',
    });
};

sub available_actions {
    my $self = shift;
    return [keys %{$self->actions}];
}

sub use_action {
    my ($self, $action) = @_;
    my $available = $self->available_actions;
    if ($action ~~ $available) {
        my $out = $self->actions->{$action}->();
        if ($out) {
            Adventure->player->announce($out);
        }
    }
    else {
        Adventure->player->announce('There is no action named '.$action.'.');
    }
}

1;
