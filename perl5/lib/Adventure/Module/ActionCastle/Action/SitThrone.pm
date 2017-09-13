package Adventure::Module::ActionCastle::Action::SitThrone;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->location eq 'throne') {
        if (Adventure->player->property('royalty') == 1) {
            Adventure->player->announce('You sit on the ornate golden throne. The people cheer for the new ruler of Action Castle! Game over.');
            Adventure->player->game_over;
        }
        else {
            Adventure->player->announce("You think better of it since you are not royalty.");
        }
    }
    else {
        Adventure->player->announce("You can't do that here.");
    }
    return;

}

1;
