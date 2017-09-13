package Adventure::Module::ActionCastle::Action::UnlockDoor;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('key')) {
        if (Adventure->player->location eq 'towerstairs') {
            Adventure->player->location_object->property('door_is_unlocked', 1);
            Adventure->player->announce('Hot damn, the door is unlocked!');
        }
        else {
            Adventure->player->announce("There's nothing to unlock here.");
        }
    }
    else {
        Adventure->player->announce("You don't have a key.");
    }
    return;

}

1;
