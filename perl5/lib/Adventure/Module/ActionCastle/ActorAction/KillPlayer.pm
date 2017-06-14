package Adventure::Module::ActionCastle::ActorAction::KillPlayer;

sub main {
    my ($game, $player, $actor, $params) = @_;
    Adventure->player->announce($params->{description});
    Adventure->player->kill();
}

1;
