package MooRooAction;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Action;


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
   my $action = Adventure::Action->new;
   isa_ok($action, 'Adventure::Action');
   diag 'No Attributes';
   #my @a = qw();
   #foreach my $i (@a) { can_ok $action, $i; }
   diag 'Methods';
   my @m = qw(init perform);
   foreach my $i (@m) { can_ok $action, $i; }
   diag 'Inherited Attribute(s)';
   can_ok $action, 'key';
   diag 'Inherited Method(s)';
   can_ok $action, 'init';

};

test 'roles' => sub { 
   my $action = Adventure::Action->new;
   isa_ok($action, 'Adventure::Action');
   my @r = qw(Adventure::Role::Aliases);
   foreach my $i (@r) { ok($action->does($i), "Does Role $i"); }
};

run_me;
done_testing;
exit 0;
