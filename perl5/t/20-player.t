use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Ouch;

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

    cmp_ok $player->has_item('fish'), '==', 1, 'player  has fish';

    $player->location_object->use_action('fish');

    cmp_ok $player->has_item('fish'), '==', 1, 'player still has only 1 fish';

    $player->location_object->use_exit('North');
    $player->location_object->use_exit('North');

    $player->location_object->use_exit('East');

    cmp_ok $player->location, 'eq', 'bridge', 'is the player at the bridge';

    $player->end_turn;
    $player->end_turn;
    $player->end_turn;
    $player->end_turn;
    eval { $player->end_turn };
    if (kiss 'game over') {
        pass "We should have died, but we're going to keep going, because we're immortal.";
        # reset the condition so we don't keep dying
        Adventure->get_location('bridge')->property('turn_count',0);
    }
    $player->display_score;

    $player->location_object->use_exit('East');
    cmp_ok $player->location, 'eq', 'bridge', 'is the player is still at the bridge';

    Adventure->get_actor('troll')->use_action('give troll fish');

    cmp_ok $player->has_item('fish'), '==', 0, 'player does not have fish';
    cmp_ok Adventure->player->location_object->property('troll_fed'), '==', 1, 'troll has fish';

    $player->location_object->use_exit('East');
    cmp_ok $player->location, 'eq', 'courtyard', 'is the player is at the courtyard';

    Adventure->get_actor('guard')->use_action('hit guard with branch');

    cmp_ok $player->location_object->has_actor('koguard'), '==', 1, 'guard is ko';

    $player->location_object->get_actor('koguard')->put_item('key', $player);
    cmp_ok $player->has_item('key'), '==', 1, 'player has key';

    $player->location_object->use_exit('East');
    cmp_ok $player->location, 'eq', 'hall', 'is the player is at the hall';

    $player->location_object->put_item('candle', $player);
    cmp_ok $player->has_item('candle'), '==', 1, 'player has candle';

    $player->location_object->use_exit('West');
    cmp_ok $player->location, 'eq', 'courtyard', 'is the player is at the courtyard';

    $player->location_object->use_exit('Down');
    cmp_ok $player->location, 'eq', 'dungeonstairs', 'is the player is at the dungeonstairs';

    $player->get_item_object('unlitlamp')->use_action('light');
    cmp_ok $player->has_item('lamp'), '==', 1, 'we have lit the lamp';

    $player->display_inventory;


};


done_testing;
