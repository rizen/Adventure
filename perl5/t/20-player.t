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

    isa_ok($player->location_object, 'Adventure::Location', 'player can get its location object');

    $player->location_object->use_exit('Out');

    cmp_ok $player->location, 'eq', 'gardenpath', 'is the player at the garden path';

    $player->location_object->use_exit('North');
    $player->location_object->use_exit('Up');

    cmp_ok $player->location, 'eq', 'tree', 'is the player in the tree';

    $player->location_object->use_action('jump');

};


done_testing;
