#!/usr/bin/env perl
use strict; use warnings;
use feature qw(say);
use Text::ParseWords;
use FindBin::libs;
use Adventure;
use Adventure::Command;

Adventure->init('../missions/actioncastle.yaml');
my $player = Adventure->player;

while (<>) {
   chomp;
   $_ = lc;
   my $line = $_;
   my @words = quotewords('\s+', 0, $line );
   slacker_parse('Adventure', $player, \@words);
}
say "done";
exit 0;

sub slacker_parse {
   my ($game, $player, $ra_words) = @_;
   my $cmd_method = 'cmd_' .  ${$ra_words}[0];
   if (Adventure::Command->can($cmd_method)) {
      Adventure::Command->$cmd_method($game,$player,$ra_words);
   }
   else {
      say 'Thats not fair';
   }
   return;
}
