package MooRooAdventure;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;


# before tests begin
before  setup     => sub { say 'begin  setup'; }; 

# after tests finish
after   teardown  => sub { say 'after  setup'; };

before  each_test => sub { say 'before test'; };
after   each_test => sub { say 'after  test'; };

test 'definition' => sub { 
   my $adv = Adventure->new;
   isa_ok($adv, 'Adventure');
   diag 'No Attributes';
   #   my @a = qw();
   #   foreach my $i (@a) { can_ok $base, $i; }
   diag 'Methods';
   my @m = qw( import
	       config
	       name
	       locations
	       location
	       items
	       item
	       actors
	       actor
	       player
	       init
	       add_player
	       add_locations
	       add_location
	       add_items
	       add_item
	       available_items
	       item_exists
	       add_actors
	       add_actor
	       Adv_Add_Plugin
             );
   foreach my $i (@m) { can_ok $adv, $i; }
   diag 'No Inherited Attribute(s)';
   diag 'No Inherited Method(s)';
};

test 'roles' => sub { 
   ok(1,'No Roles to test');
};

run_me;
done_testing;
exit 0;
