package Adventure::Module::ActionCastle::Action::Propose;

sub main {
    my ($class, $params) = @_;
    if (Adventure->player->has_item('crown')) {
        if (Adventure->player->location eq 'tower') {
            Adventure->player->remove_item('crown');
            Adventure->player->location_object->replace_actor('happyprincess','queen');
            Adventure->get_location('courtyard')->replace_actor('koguard','humbleguard');
            my $append = ' It is full of revelers celebrating the new ruler of Action Castle!';
            Adventure->get_location('hall')->description(Adventure->get_location('hall')->description . $append);
            Adventure->get_location('throne')->description(Adventure->get_location('throne')->description . $append);
            Adventure->player->property('royalty', 1);
            Adventure->player->announce('My father\'s crown! You have put his soul at rest and you may now succeed him! I accept." Places crown on your head.');
        }
        else {
            Adventure->player->announce("There's no one who wants that here.");
        }
    }
    else {
        Adventure->player->announce("You're not royalty!");
    }
    return;

}

1;
