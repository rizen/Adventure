package Adventure::Module::ActionCastle::Exit::Blocked;

sub main {
    my ($game, $player, $params) = @_;
    if ($game->actor($params->{blocker})->property($params->{blocker_property})) {
        return $params->{destination};
    }
    else {
        $player->announce($params->{description});
        return $player->location;
    }
}

1;
