package Adventure::Module::ActionCastle::Action::GoFishing;

sub main {
    my ($class) = @_;
    if (!Adventure->player->location_object->has_item('fish')) {
        Adventure->player->announce("you already caught one. hot damn");
    }
    else {
        if (Adventure->player->has_item('fishpole')) {
            Adventure->player->location_object->put_item('fish', Adventure->player);
            Adventure->player->announce("You caught a fish! Hot damn.");
        }
        else {
            Adventure->player->announce("You splash around in the pond and scare the fish.");
        }
    }
    return;
}

1;
