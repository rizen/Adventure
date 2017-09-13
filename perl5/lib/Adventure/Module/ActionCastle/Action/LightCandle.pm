package Adventure::Module::ActionCastle::Action::LightCandle;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('candle')) {
        if (Adventure->player->location eq 'dungeon') {
            Adventure->player->remove_item('candle');
            Adventure->player->add_item('litcandle');
            Adventure->player->announce('Candle is lit and gives off an acrid smoke.');
            Adventure->player->location_object->remove_actor('ghost');
            Adventure->player->location_object->add_item('crown');
            Adventure->player->announce('At the touch of the acrid smoke the ghost drops its crown and flees.');
        }
        else {
            Adventure->player->announce("You cannot do that here.");
        }
    }
    else {
        Adventure->player->announce("You don't have an unlit candle.");
    }
    return;

}

1;
