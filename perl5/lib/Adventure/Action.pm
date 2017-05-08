use strict;
use warnings;
package Adventure::Action;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Aliases';

sub perform {}

sub init {
    my ($self, $key, $config) = @_;
    if (ref $config eq 'HASH') {
        if (exists $config->{description}) {
            after perform => sub {
                Adventure->player->announce($config->{description});
            };
        }
        if (exists $config->{code}) {
            my $code = $config->{code};
            warn "Must implement code loading. Would have executed: ".$code;
            # $code->($config->{params});
        }
    }
    else {
        after perform => sub {
            Adventure->player->announce($config);
        };
    }
}

1;
