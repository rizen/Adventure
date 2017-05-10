use strict;
use warnings;
use Test::More;
use FindBin::libs;

use_ok('Adventure');
Adventure->init('../missions/actioncastle.yaml');

subtest 'move' => sub {

    my $player = Adventure->player;

    isa_ok($player, 'Adventure::Player');

    cmp_ok $player->location, 'eq', 'cottage', 'is the player at the cottage';

    #my $location = Adventure->location($player->location);
    #my $location = $player->location_object;

    isa_ok($player->location_object, 'Adventure::Location', 'player can get its location object');

};


done_testing;
