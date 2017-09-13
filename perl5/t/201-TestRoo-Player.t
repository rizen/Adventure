package MooRooPlayer;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Player;


# before tests begin
before  setup     => sub { 
   say 'begin  setup';
   #Adventure->init('./missions/actioncastle.yaml');
};

# after tests finish
after   teardown  => sub { say 'after  setup'; };

before  each_test => sub { say 'before test'; };
after   each_test => sub { say 'after  test'; };

test 'definition' => sub { 
   my $player = Adventure::Player->new;
   isa_ok($player, 'Adventure::Player');
   diag 'Attributes';
   my @a = qw(location score);
   foreach my $i (@a) { can_ok $player, $i; }
   diag 'Methods';
   my @m = qw(location_object announce kill display_score);
   foreach my $i (@m) { can_ok $player, $i; }
   diag 'Inherited Attribute(s)';
   can_ok $player, 'key';
   diag 'Inherited Method(s)';
   can_ok $player, 'init';
};
test 'roles' => sub { 
   my $player = Adventure::Player->new;
   isa_ok($player, 'Adventure::Player');
   my @r = qw(Adventure::Role::Thing      Adventure::Role::Aliases 
              Adventure::Role::Properties Adventure::Role::Actions 
	      Adventure::Role::Items
	      );
   foreach my $i (@r) { ok($player->does($i), "Does Role $i"); }

};

run_me;
done_testing;
exit 0;
