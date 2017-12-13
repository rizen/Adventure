package Adventure::Module::ActionCastle::Turn::ReceiveCommand;

sub main {
    my ($class, $params) = @_;
    Adventure->player->game_object->property('game_turn_count',Adventure->player->game_object->property('game_turn_count') + 1);

     # delete all below... -sk.
#        if (Adventure->player->location_object->property('turn_count') > 4) {
#            Adventure->player->kill('The troll beat you to death. Hot damn');
#        }
#    }
#    else {
#        Adventure->get_location('bridge')->property('turn_count',0);
#    }
     # delete all above... -sk.

    return;
}

1;
