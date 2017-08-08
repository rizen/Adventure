package Adventure::Module::ActionCastle::Turn::TrollRage;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->location eq 'bridge') {
        Adventure->player->location_object->property('turn_count',Adventure->player->location_object->property('turn_count') + 1);
        if (Adventure->player->location_object->property('turn_count') > 4) {
            Adventure->player->kill('The troll beat you to death. Hot damn');
        }
        else {
            Adventure->player->location_object->property('turn_count',0);
        }
    }
}

1;
