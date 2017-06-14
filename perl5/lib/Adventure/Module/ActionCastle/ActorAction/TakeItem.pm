package Adventure::Module::ActionCastle::ActorAction::TakeItem;

sub main {
    my ($game, $player, $actor, $params) = @_;
    if ($game->item_exists($params->{item})) {
        if ($actor->has_item($params->{item}, $params->{quantity})) {
            $actor->remove_item($params->{item}, $params->{quantity});
            $player->add_item($params->{item}, $params->{quantity});
            $player->announce('You have a '.$game->item($params->{item}).'.');
        }
        else {
            $player->announce($actor->name.' has no '.$game->item($params->{item}).'.');
        }
    }
    else {
        $player->announce("I don't know what that is.");
    }
}

1;
