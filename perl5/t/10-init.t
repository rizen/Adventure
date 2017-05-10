use strict;
use warnings;
use Test::More;
use FindBin::libs;


subtest 'init' => sub {

    use_ok('Adventure');

    eval {
        Adventure->init('../missions/actioncastle.yaml');
    };

    unless ( ok( ! $@, "init ran without error") )
    {
        diag("Error was: $@");
        exit;
    }
};

subtest 'actors' => sub {

    ok( ref Adventure->actors eq 'HASH', "actors hash")
        || return;
    ok( %{Adventure->actors}, "found at least one actor");
    cmp_ok( Adventure->actor('throne')->name, 'eq', 'Throne',
        "actor 'throne' exists and has proper name" );
};


subtest 'items' => sub {

    ok( ref Adventure->items eq 'HASH', "items hash")
        || return;
    ok( %{Adventure->items}, "found at least one items");
    cmp_ok( Adventure->item('candle')->name, 'eq', 'Strange Candle',
        "item 'candle' exists and has proper name" );
};

subtest 'locations' => sub {

    ok( ref Adventure->locations eq 'HASH', "locations hash")
        || return;
    ok( %{Adventure->locations}, "found at least one location");
    cmp_ok( Adventure->location('tree')->name, 'eq', 'Top of the Tall Tree',
        "location 'tree' exists and has proper name" );
};


subtest 'player' => sub {

    ok( ref Adventure->player eq 'Adventure::Player', "player object")
        || return;
    cmp_ok( Adventure->player->score, '==', 0,
        "initial score is zero");
};

done_testing;
