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



};


done_testing;
