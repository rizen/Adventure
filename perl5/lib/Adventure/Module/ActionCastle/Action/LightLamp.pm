package Adventure::Module::ActionCastle::Action::LightLamp;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('unlitlamp')) {
        Adventure->player->remove_item('unlitlamp');
        Adventure->player->add_item('lamp');
        Adventure->player->location_object->property('dungeon_is_lit', 1);
        Adventure->player->announce('Lamp is lit!');
    }
    else {
        Adventure->player->announce("You don't have an unlit lamp.");
    }
    return;

}

1;
