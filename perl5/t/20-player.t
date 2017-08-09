use strict;
use warnings;
use Test::Most;
use FindBin::libs;

use_ok('Adventure');
Adventure->init('./missions/actioncastle.yaml');

subtest 'move' => sub {

    my $player = Adventure->player;

    isa_ok($player, 'Adventure::Player');

    cmp_ok $player->location, 'eq', 'cottage', 'is the player at the cottage';

    $player->location_object->put_item('fishpole', $player);

    isa_ok($player->location_object, 'Adventure::Location', 'player can get its location object');

    $player->location_object->use_exit('Out');

    cmp_ok $player->location, 'eq', 'gardenpath', 'is the player at the garden path';

    $player->location_object->use_exit('North');
    $player->location_object->use_exit('Up');

    cmp_ok $player->location, 'eq', 'tree', 'is the player in the tree';

    $player->location_object->use_action('jump');

    cmp_ok $player->location, 'eq', 'tree', 'is the player is still in the tree';

    cmp_ok $player->has_item('branch'), '==', 0, 'player does not have branch';
    cmp_ok $player->location_object->has_item('branch'), '==', 1, 'tree has branch';

#    eval {
#        $player->location_object->put_item('nosuchobject', $player);
#    }; # todo use throws_ok
#    ok $@, 'it failed on an invalid item';
    throws_ok {
        $player->location_object->put_item('nosuchobject', $player);
    }
    qr//,
    'it failed on an invalid item';

#    eval {
#        $player->location_object->put_item('branch', '');
#    };
#    ok $@, 'it failed on an invalid object';
    throws_ok {
       $player->location_object->put_item('branch', '');
    }
    qr//,
    'it failed on an invalid object';

    cmp_ok $player->location_object->has_item('branch'), '==', 1, 'tree still has branch';

    lives_ok {
       $player->location_object->put_item('branch', $player);
    }
    'Associate the branch with player';

    cmp_ok $player->has_item('branch'), '==', 1, 'player has branch';
    cmp_ok $player->location_object->has_item('branch'), '==', 0, 'tree does not have branch';

    $player->location_object->use_exit('Down');
    $player->location_object->use_exit('South');
    $player->location_object->use_exit('South');

    $player->location_object->use_action('fish');

    $player->end_turn;
    $player->end_turn;
    $player->end_turn;
    $player->display_score;
    
};


done_testing;
