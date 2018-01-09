use strict;
use warnings;
use Test::Most 'no_plan';
use FindBin::libs;
use Text::ParseWords;
use Ouch;

use_ok('Adventure');
Adventure->init('../missions/actioncastle.yaml');

subtest 'move' => sub {

    my $player = Adventure->player;

    isa_ok($player, 'Adventure::Player');

    cmp_ok $player->location, 'eq', 'cottage', 'is the player at the cottage';

    # Verb:take:
    # Verb:pickup: (or)
    # DObject:fishpole:
    my @words = quotewords('\s+', 0, q{take fishpole});
    cmp_ok $words[0], 'eq', 'take', 'this is verb taking';
    cmp_ok $words[1], 'eq', 'fishpole', 'thing is fishpole';
    
    $player->location_object->put_item('fishpole', $player);

    isa_ok($player->location_object, 'Adventure::Location', 'player can get its location object');

    # Verb:go:
    # DObject:Out:
    @words = quotewords('\s+', 0, q{go Out});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'Out', 'thing is Out';
    
    $player->location_object->use_exit('Out');

    cmp_ok $player->location, 'eq', 'gardenpath', 'is the player at the garden path';
    $player->location_object->get_actor('bush')->put_item('rose', $player);

    # Verb:go:
    # DObject:North:
    @words = quotewords('\s+', 0, q{go North});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'North', 'thing is North';

    $player->location_object->use_exit('North');

    cmp_ok $player->location, 'eq', 'windingpath', 'is the player at the winding path';

    # Verb:go:
    # DObject:Up:
    @words = quotewords('\s+', 0, q{go Up});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'Up', 'thing is Up';

    $player->location_object->use_exit('Up');

    cmp_ok $player->location, 'eq', 'tree', 'is the player in the tree';

    # Verb:jump:
    # DObject N/A
    @words = quotewords('\s+', 0, q{jump});
    cmp_ok $words[0], 'eq', 'jump', 'this is verb jump';
    # No Direct Object required ... cmp_ok $words[1], 'eq', ... anything...

    $player->location_object->use_action('jump');

    cmp_ok $player->location, 'eq', 'tree', 'is the player is still in the tree';

    cmp_ok $player->has_item('branch'), '==', 0, 'player does not have branch';
    cmp_ok $player->location_object->has_item('branch'), '==', 1, 'tree has branch';

    # Verb:take:
    # Verb:pickup: (or)
    # Verb:put: (not really)
    # DObject N/A
    @words = quotewords('\s+', 0, q{take});
    cmp_ok $words[0], 'eq', 'go', 'this is verb take';
    # No Direct Object given ... cmp_ok $words[1], 'eq', ... nothing...

    eval {
        $player->location_object->put_item('nosuchobject', $player);
    }; # todo use throws_ok
    ok $@, 'it failed on an invalid item';
    throws_ok {
        $player->location_object->put_item('nosuchobject', $player);
    }
    qr//,
    'it failed on an invalid item';

    # Verb:take:
    # Verb:pickup: (or)
    # Verb:put: (not really, but could be "put branch to me"?)
    # DObject:branch:
    @words = quotewords('\s+', 0, q{take branch});
    cmp_ok $words[0], 'eq', 'go', 'this is verb take';
    cmp_ok $words[1], 'eq', 'branch', 'thing is branch';

#    eval {
#        $player->location_object->put_item('branch', '');
#    };
#    ok $@, 'it failed on an invalid object';
#    throws_ok {
#       $player->location_object->put_item('branch', '');
#    }
#    qr//,
#    'it failed on an invalid object';

    cmp_ok $player->location_object->has_item('branch'), '==', 1, 'tree still has branch';

    lives_ok {
       $player->location_object->put_item('branch', $player);
    }
    'Associate the branch with player';

    cmp_ok $player->has_item('branch'), '==', 1, 'player has branch';
    cmp_ok $player->location_object->has_item('branch'), '==', 0, 'tree does not have branch';

    # Verb:go:
    # DObject:Down:
    @words = quotewords('\s+', 0, q{go Down});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'Down', 'thing is Down';

    $player->location_object->use_exit('Down');

    # Verb:go:
    # DObject:South:
    @words = quotewords('\s+', 0, q{go South});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'South', 'thing is South';

    $player->location_object->use_exit('South');

    # Repeat last command ... "." or something?
    $player->location_object->use_exit('South');

    # Verb:fish:
    # DObject N/A
    @words = quotewords('\s+', 0, q{fish});
    cmp_ok $words[0], 'eq', 'fish', 'this is verb fish';
    # No Direct Object required ... cmp_ok $words[1], 'eq', ... anything...

    $player->location_object->use_action('fish');

    cmp_ok $player->has_item('fish'), '==', 1, 'player  has fish';

    # Repeat last command ... "." or something?
    $player->location_object->use_action('fish');

    cmp_ok $player->has_item('fish'), '==', 1, 'player still has only 1 fish';

    # Verb:go:
    # DObject:North:
    @words = quotewords('\s+', 0, q{go North});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'North', 'thing is North';

    $player->location_object->use_exit('North');

    # Repeat last command ... "." or something?
    $player->location_object->use_exit('North');

    # Verb:go:
    # DObject:East:
    @words = quotewords('\s+', 0, q{go East});
    cmp_ok $words[0], 'eq', 'go', 'this is verb go';
    cmp_ok $words[1], 'eq', 'East', 'thing is East';

    $player->location_object->use_exit('East');

    cmp_ok $player->location, 'eq', 'bridge', 'is the player at the bridge';

    # Verb:wait:
    # Verb:sleep: (or)
    # DObject N/A
    @words = quotewords('\s+', 0, q{wait});
    cmp_ok $words[0], 'eq', 'wait', 'this is verb wait';
    # No Direct Object required ... cmp_ok $words[1], 'eq', ... anything...

    $player->end_turn;

    # Repeat last command ... "." or something?
    $player->end_turn;

    # Repeat last command ... "." or something?
    $player->end_turn;

    # Repeat last command ... "." or something?
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

    # Verb:give:
    # DObject:troll:
    # IObject:fish:
    @words = quotewords('\s+', 0, q{give troll fish});
    cmp_ok $words[0], 'eq', 'give', 'this is verb give';
    cmp_ok $words[1], 'eq', 'troll', 'thing is troll';
    cmp_ok $words[2], 'eq', 'fish', 'other thing is fish';

    Adventure->get_actor('troll')->use_action('give troll fish');

    cmp_ok $player->has_item('fish'), '==', 0, 'player does not have fish';
    cmp_ok Adventure->player->location_object->property('troll_fed'), '==', 1, 'troll has fish';

    $player->location_object->use_exit('East');
    cmp_ok $player->location, 'eq', 'courtyard', 'is the player is at the courtyard';

    # Verb:hit:
    # DObject:guard:
    # Prep:with:
    # IObject:branch:
    @words = quotewords('\s+', 0, q{hit guard with branch});
    cmp_ok $words[0], 'eq', 'hit', 'this is verb hit';
    cmp_ok $words[1], 'eq', 'guard', 'thing is guard';
    cmp_ok $words[2], 'eq', 'with', 'preposition is with';
    cmp_ok $words[3], 'eq', 'branch', 'other thing is branch';

    Adventure->get_actor('guard')->use_action('hit guard with branch');

    cmp_ok $player->location_object->has_actor('koguard'), '==', 1, 'guard is ko';

    # Verb:take:
    # DObject:key:
    # Prep:from:
    # IObject:guard:
    @words = quotewords('\s+', 0, q{take key from guard});
    cmp_ok $words[0], 'eq', 'take', 'this is verb take';
    cmp_ok $words[1], 'eq', 'key', 'thing is key';
    cmp_ok $words[2], 'eq', 'from', 'preposition is from';
    cmp_ok $words[3], 'eq', 'guard', 'other thing is guard';

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
