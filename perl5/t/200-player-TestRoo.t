package MooRoo;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;

# before tests begin
before  setup     => sub { 
   say 'before setup'; 
   Adventure->init('./missions/actioncastle.yaml');
};

# after tests finish
after   teardown  => sub { say 'after  setup'; };

before  each_test => sub { say 'before test'; };
after   each_test => sub { say 'after  test'; };

test 'move' => sub { 
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

    throws_ok {
        $player->location_object->put_item('nosuchobject', $player);
    }
    qr//,
    'it failed on an invalid item';

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
};

test 'runaway' => sub { 
   say 'test two'; 
   ok(2, 'simple test');
};

run_me;
done_testing;
exit 0;
