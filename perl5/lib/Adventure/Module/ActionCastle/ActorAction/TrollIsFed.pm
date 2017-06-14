package Adventure::Module::ActionCastle::ActorAction::TrollIsFed;

sub main {
    my ($game, $player, $actor, $params) = @_;
    if ($player->has_item('fish')) {
        $player->remove_item('fish');
        $player->location->property('troll_fed', 1);
        $actor->remove('troll');
        $player->announce('Satisfied, the troll leaves with his fish.');
    }
    else {
        $player->announce("You don't have a fish.");
    }
}

1;
