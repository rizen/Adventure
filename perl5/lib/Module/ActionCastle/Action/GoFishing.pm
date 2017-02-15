package Adventure::Module::ActionCastle::Action::GoFishing;

sub main {
    my ($game, $player, $params) = @_;
    if ($player->location->property('caught_fish')) {
        $player->announce("you already caught one. hot damn");
    }
    else {
        if ($player->inventory->contains('fishpole')) {
            $player->add_item('fish',1);
            $player->location->property('caught_fish',1);
            $player->announce("You caught a fish! Hot damn.");
        }
        else {
            $player->announce("You splash around in the pond and scare the fish.");
        }
    }
}

1;
