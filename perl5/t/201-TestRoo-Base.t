package MooRooBase;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Base;


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
   my $base = Adventure::Base->new;
   isa_ok($base, 'Adventure::Base');
   my @a = qw(key);
   diag 'Attributes';
   foreach my $i (@a) { can_ok $base, $i; }
   diag 'Methods';
   my @m = qw(init);
   foreach my $i (@m) { can_ok $base, $i; }
   diag 'No Inherited Stuff';
};

test 'roles' => sub { 
   ok(1,'No Roles to test');
};

run_me;
done_testing;
exit 0;
