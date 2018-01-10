package MooRooLocation;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Location;


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
   my $location = Adventure::Location->new;
   isa_ok($location, 'Adventure::Location');
   diag 'Attributes';
   my @a = qw(exits actors);
   foreach my $i (@a) { can_ok $location, $i; }
   diag 'Methods';
   my @m = qw( available_exits
               use_exit
               add_actors
               add_actor
               remove_actor
               has_actor
               replace_actor
               );
   foreach my $i (@m) { can_ok $location, $i; }
   diag 'Inherited Attribute(s)';
   can_ok $location, 'key';
   diag 'Inherited Method(s)';
   can_ok $location, 'init';
};

test 'roles' => sub { 
   my $location = Adventure::Location->new;
   isa_ok($location, 'Adventure::Location');
   my @r = qw( Adventure::Role::Thing      Adventure::Role::Aliases
               Adventure::Role::Properties Adventure::Role::Actions
               Adventure::Role::Items
	       );
   
   foreach my $i (@r) { ok($location->does($i), "Does Role $i"); }
};

run_me;
done_testing;
exit 0;
