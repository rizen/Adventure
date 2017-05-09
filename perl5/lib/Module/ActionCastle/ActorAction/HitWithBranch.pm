package Adventure::Module::ActionCastle::ActorAction::HitWithBranch;

sub main {
    my ($game, $player, $actor, $params) = @_;
    if ($player->has_item('branch')) {
        $player->remove_item('branch');
        $player->location->property('guard_is_ko', 1);
        $player->location->replace_actor('guard','koguard');
        $player->announce('You strike the guard with the branch, it shatters, and he falls to the ground unconscious.');
    }
    else {
        $player->announce("You don't have a branch.");
    }
}

1;
