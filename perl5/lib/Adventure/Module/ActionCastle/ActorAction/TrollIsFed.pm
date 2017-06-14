package Adventure::Module::ActionCastle::ActorAction::TrollIsFed;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('fish')) {
        Adventure->player->remove_item('fish');
        Adventure->player->location->property('troll_fed', 1);
        Adventure->actor->remove('troll');
        Adventure->player->announce('Satisfied, the troll leaves with his fish.');
    }
    else {
        Adventure->player->announce("You don't have a fish.");
    }
}

1;
