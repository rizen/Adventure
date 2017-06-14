package Adventure::Module::ActionCastle::Exit::Blocked;

=head1 NAME

Blocked

=head1 DESCRIPTION

An exit is blocked until some condition is met. Displays a special announcement until then.

=head1 PARAMS

A hash reference of parameters.

=over

=item allow_property

The name of the property set on the L<Adventure::Player> object to allow the player to pass.

=item destination

The key name of the L<Adventure::Location> where the player should end up if the C<allow_property> is set.

=item description

The message to send if the player does not yet have the C<allow_property> set.

=back

=cut

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->location->property($params->{allow_property})) {
        return $params->{destination};
    }
    else {
        Adventure->player->announce($params->{description});
        return Adventure->player->location;
    }
}

1;
