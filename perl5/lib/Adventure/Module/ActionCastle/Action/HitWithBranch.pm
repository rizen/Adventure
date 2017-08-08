package Adventure::Module::ActionCastle::Action::HitWithBranch;

sub main {
    my ($class, $params) = @_;
    # if (Adventure->player->has_item('branch')) {
    #     Adventure->player->remove_item('branch');
    #     Adventure->player->location_object->property('guard_is_ko', 1);
    #     Adventure->player->location_object->replace_actor('guard','koguard');
    #     Adventure->player->announce('You strike the guard with the branch, it shatters, and he falls to the ground unconscious.');
    # }
    # else {
    #     Adventure->player->announce("You don't have a branch.");
    # }
    return;

}

1;
