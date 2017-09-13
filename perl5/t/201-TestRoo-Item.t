package MooRooItem;
use strict;
use warnings;
use Test::Most;
use FindBin::libs;
use Test::Roo;
use feature 'say';
use Adventure;
use Adventure::Item;


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
   my $item = Adventure::Item->new;
   isa_ok($item, 'Adventure::Item');
   diag 'No Attributes';
   #my @a = qw();
   #foreach my $i (@a) { can_ok $item, $i; }
   diag 'No Methods';
   #my @m = qw();
   #foreach my $i (@m) { can_ok $item, $i; }
   diag 'Inherited Attribute(s)';
   can_ok $item, 'key';
   diag 'Inherited Method(s)';
   can_ok $item, 'init';
};

test 'roles' => sub { 
   my $item = Adventure::Item->new;
   isa_ok($item, 'Adventure::Item');
   my @r = qw( Adventure::Role::Thing Adventure::Role::Aliases
               Adventure::Role::Properties Adventure::Role::Actions
             );
   foreach my $i (@r) { ok($item->does($i), "Does Role $i"); }
};


run_me;
done_testing;
exit 0;
