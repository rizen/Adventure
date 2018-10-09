#!/usr/bin/env perl
use strict; use warnings;
use feature qw(say switch);
#use experimental qw(smartmatch);
#no warnings qw( experimental::smartmatch );
use Text::ParseWords;
#use FindBin::libs;
#use Ouch;
use Adventure;

Adventure->init('../missions/actioncastle.yaml');
my $player = Adventure->player;

while (<>) {
   chomp;
   my $line = $_;
   my @words = quotewords('\s+', 0, $line );
   brute_parse(\@words);
}
say "done";
exit 0;

sub brute_parse {
  my ($ra_words) = @_;

  #my @words = quotewords('\s+', 0, q{move Out});
  #my @words = quotewords('\s+', 0, q{sit on throne});
  #given ($$words[0]) {
  for ($$ra_words[0]) {     # 5.14: according to perlsyn
     if    (/exit/)                    { say 'exit';         $player->game_over(); }
     elsif (/move/)                    { say 'move DIRECTION'; move($player,$ra_words);}
     elsif (/take/)                    { say 'take OBJECT from CHARACTER' }
     elsif (/unlock/)                  { say 'unlock tower door'}
     elsif (/cast/)                    { say 'cast OBJECT' }
     elsif (/cast|use|go/)             { say 'cast fishpole' }
     elsif (/jump/)                    { say 'you can only jump out of a tree' }
     elsif (/sit/)                     { say 'sit on OBJECT'; sit($player,$ra_words) }
     elsif (/kiss/)                    { say 'kiss CHARACTER' }
     elsif (/feed/)                    { say 'feed CHARACTER OBJECT' }
     elsif (/give/)                    { say 'give CHARACTER OBJECT' or say 'give OBJECT to CHARACTER' }
     elsif (/light/)                   { say 'light OBJECT'; light($player, $ra_words) }
     elsif (/wear/)                    { say 'wear OBJECT' }
     elsif (/smell/)                   { say 'wear OBJECT' }
     elsif (/pickup|drop|throw/)       { say 'use OBJECT'; pickup($player, $ra_words) }
     elsif (/fight|attack|punch|kill/) { say 'fight CHARACTER' }
     elsif (/whack|hit/)               { say 'hit CHARACTER with OBJECT' }
     else                              { say 'Thats not fair' }
  }
  return;
} 

sub light {
   my ($player, $ra_words) = @_;
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your LIGHT sentence sux'); return;
   }

   if ( not ($player->has_item($$ra_words[1]) ) ) {
      $player->announce('you do not have that item'); return;
   }
   $player->get_item_object($$ra_words[1])->use_action('light');
   return;

}

sub pickup {
   my ($player, $ra_words) = @_;
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your PICKUP sentence sux'); return;
   }

   if (not ($player->location_object->has_item($$ra_words[1]) ) ) {
      $player->announce('Location does not have that'); return;
   }

   $player->location_object->put_item($$ra_words[1], $player);
   return;
}

sub move { # ex. move north
   my ($player, $ra_words) = @_;
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your MOVE sentence sux'); return;
   }

   # will Adventure->player->announce('There is no exit named '.$exit.'.')
   $player->location_object->use_exit($$ra_words[1]);
   return;
}

sub sit {  # ex. sit on throne
   my ($player, $ra_words) = @_;
   if ( not (scalar @$ra_words) == 3 ) {
      $player->announce('your SIT sentence sux'); return;
   }

   # Does this location have this actor
   if (not ($player->location_object->has_actor($$ra_words[2]) ) ) {
      $player->announce('Location does not have that'); return;
   }

   $player->location_object->get_actor($$ra_words[2])->use_action($$ra_words[0]);
   return;
}
