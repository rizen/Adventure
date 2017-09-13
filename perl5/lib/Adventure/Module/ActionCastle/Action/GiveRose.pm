package Adventure::Module::ActionCastle::Action::GiveRose;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('rose')) {
        if (Adventure->player->location eq 'tower') {
            Adventure->player->remove_item('rose');
            Adventure->player->location_object->replace_actor('sadprincess','happyprincess');
            Adventure->player->announce('She takes the rose, smiles, and looks ready to talk.');
        }
        else {
            Adventure->player->announce("There's no one who wants that here.");
        }
    }
    else {
        Adventure->player->announce("You don't have a rose.");
    }
    return;

}

1;
