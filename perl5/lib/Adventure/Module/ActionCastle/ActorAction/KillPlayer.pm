package Adventure::Module::ActionCastle::ActorAction::KillPlayer;

sub main {
    my ($game, $player, $actor, $params) = @_;
    $player->announce($params->{description});
    $player->kill();
}

1;
