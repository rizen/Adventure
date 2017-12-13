use strict;
use warnings;
use Test::Most 'no_plan';
use FindBin::libs;
use Text::ParseWords;
use Ouch;

use_ok('Adventure');
Adventure->init('../missions/actioncastle.yaml');

# 1..2 call to sub is assumed. -sk.
subtest 'move' => sub {

    my $player = Adventure->player;

    isa_ok($player, 'Adventure::Player');

    cmp_ok $player->location, 'eq', 'cottage', 'is the player at the cottage';

    # take or pickup:
    # Object: fishpole
    my @words = quotewords('\s+', 0, q{take fishpole});
    cmp_ok $words[0], 'eq', 'take', 'this is verb taking';
    cmp_ok $words[1], 'eq', 'fishpole', 'thing is fishpole';
    
    $player->location_object->put_item('fishpole', $player);

    isa_ok($player->location_object, 'Adventure::Location', 'player can get its location object');

    # go:
    # Object: Out
    my @words = quotewords('\s+', 0, q{go Out});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'Out', 'thing is Out';
    
    $player->location_object->use_exit('Out');

    cmp_ok $player->location, 'eq', 'gardenpath', 'is the player at the garden path';
    $player->location_object->get_actor('bush')->put_item('rose', $player);

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

    $player->location_object->use_exit('Down');
    cmp_ok $player->location, 'eq', 'dungeon', 'is the player is at the dungeon';

    cmp_ok $player->location_object->has_actor('ghost'), '==', 1, 'dungeon has ghost';

    $player->get_item_object('candle')->use_action('light');
    cmp_ok $player->has_item('litcandle'), '==', 1, 'we have lit the candle';

    cmp_ok $player->location_object->has_item('crown'), '==', 1, 'dungeon has crown';
    cmp_ok $player->location_object->has_actor('ghost'), '==', 0, 'dungeon no longer has ghost';

    $player->location_object->put_item('crown', $player);
    cmp_ok $player->location_object->has_item('crown'), '==', 0, 'dungeon no longer has crown';
    cmp_ok $player->has_item('crown'), '==', 1, 'player has crown';

    $player->location_object->use_exit('Up');
    $player->location_object->use_exit('Up');
    $player->location_object->use_exit('Up');
    cmp_ok $player->location, 'eq', 'towerstairs', 'is the player is at the tower stairs';

    $player->location_object->use_exit('Up');
    cmp_ok $player->location, 'eq', 'towerstairs', 'is the player is at the tower stairs';

    $player->get_item_object('key')->use_action('unlock tower door');
    $player->location_object->use_exit('Up');
    cmp_ok $player->location, 'eq', 'tower', 'is the player is at the tower';

    $player->location_object->get_actor('sadprincess')->use_action('give rose');
    cmp_ok $player->location_object->has_actor('happyprincess'), 'eq', 1, 'sad princess is now happy';


    $player->location_object->get_actor('happyprincess')->use_action('marry');
    cmp_ok $player->property('royalty'), 'eq', 1, 'player is now royalty';


    $player->location_object->use_exit('Down');
    $player->location_object->use_exit('Down');
    $player->location_object->use_exit('East');
    $player->location_object->use_exit('East');
    cmp_ok $player->location, 'eq', 'throne', 'is the player is at the throne';
    $player->location_object->get_actor('throne')->use_action('sit');



};


done_testing;
