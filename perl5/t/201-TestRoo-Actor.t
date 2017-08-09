package MooRooActor;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Actor;


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
   my $actor = Adventure::Actor->new;
   isa_ok($actor, 'Adventure::Actor');
   diag 'No Attributes';
   #my @a = qw();
   #foreach my $i (@a) { can_ok $actor, $i; }
   diag 'No Methods';
   #my @m = qw();
   #foreach my $i (@m) { can_ok $actor, $i; }
   diag 'Inherited Attribute(s)';
   can_ok $actor, 'key';
   diag 'Inherited Method(s)';
   can_ok $actor, 'init';
};
test 'roles' => sub { 
   my $actor = Adventure::Actor->new;
   isa_ok($actor, 'Adventure::Actor');
   my @r = qw(Adventure::Role::Thing      Adventure::Role::Aliases 
              Adventure::Role::Properties Adventure::Role::Actions 
	      Adventure::Role::Items
	      );
   foreach my $i (@r) { ok($actor->does($i), "Does Role $i"); }

};

run_me;
done_testing;
exit 0;
