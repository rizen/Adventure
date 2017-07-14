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
   say 'before setup'; 
};

# after tests finish
after   teardown  => sub { say 'after  setup'; };

before  each_test => sub { say 'before test'; };
after   each_test => sub { say 'after  test'; };

test 'one' => sub { 
   say 'test one'; 
   ok(1, 'simple test');
};

test 'two' => sub { 
   say 'test two'; 
   ok(2, 'simple test');
};

run_me;
done_testing;
exit 0;
