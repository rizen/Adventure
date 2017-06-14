package Adventure::Module::ActionCastle::ActorAction::HitWithBranch;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('branch')) {
        Adventure->player->remove_item('branch');
        Adventure->player->location->property('guard_is_ko', 1);
        Adventure->player->location->replace_actor('guard','koguard');
        Adventure->player->announce('You strike the guard with the branch, it shatters, and he falls to the ground unconscious.');
    }
    else {
        Adventure->player->announce("You don't have a branch.");
    }
}

1;
