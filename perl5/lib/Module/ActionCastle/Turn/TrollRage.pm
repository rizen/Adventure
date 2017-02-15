package Adventure::Module::ActionCastle::Turn::TrollRage;

sub before {
    my ($game, $player, $params) = @_;
}

sub after {
    my ($game, $player, $params) = @_;
    if ($player->in_location('bridge')) {
        $player->location->property('turn_count',$player->location->property('turn_count') + 1);
        if ($player->location->property('turn_count') > 4) {
            $game->over('The troll beat you to death. Hot damn');
        }
    }
    else {
        $game->location('bridge')->property('turn_count',0);
    }
}

1;
