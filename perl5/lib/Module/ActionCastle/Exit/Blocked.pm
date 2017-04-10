package Adventure::Module::ActionCastle::Exit::Blocked;

sub main {
    my ($game, $player, $params) = @_;
    if ($player->location->property($params->{allow_property})) {
        return $params->{destination};
    }
    else {
        $player->announce($params->{description});
        return $player->location;
    }
}

1;
