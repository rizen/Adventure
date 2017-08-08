package Adventure::Module::ActionCastle::Action::KillPlayer;

sub main {
    my ($class, $params) = @_;
    Adventure->player->announce($params->{description});
    Adventure->player->kill();
    return;
}

1;
