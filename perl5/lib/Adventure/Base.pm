use strict;
use warnings;
package Adventure::Base;
use Moo;
use Adventure;

sub init {
    my ($self, $key, $config) = @_;
    $self->key($key);
}

has key => (
    is  => 'rw',
    default => sub { undef },
);

# lembark said we could do this, but so far we haven't figured it out so we're manually creating the methods
# use Symbol qw(qualify_to_ref);
# foreach my $method (qw(location player item)) {
#     if (__PACKAGE__->can($method)) {
#         my $name = $method.'_object';
#         my $ref = qualify_to_ref $name;
#         my $sub = sub {
#             my $self = shift;
#             return Adventure->$method($self->$method);
#         };
#         *{$ref} = $sub;
#     }
# }


1;
