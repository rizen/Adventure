#!/usr/bin/env perl
use strict; use warnings;
use feature qw(say switch);
use experimental 'smartmatch';
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
     when (/exit/)                    { say 'exit';         $player->game_over(); }
     when (/move/)                    { say 'move DIRECTION'; move($player,$ra_words);}
     when (/take/)                    { say 'take OBJECT from CHARACTER' }
     when (/unlock/)                  { say 'unlock tower door'}
     when (/cast/)                    { say 'cast OBJECT' }
     when (/cast|use|go/)             { say 'cast fishingpole'   or say 'cast fishing pole' }
     when (/jump/)                    { say 'you can only jump out of a tree' }
     when (/sit/)                     { say 'sit on OBJECT'; sit($player,$ra_words) }
     when (/kiss/)                    { say 'kiss CHARACTER' }
     when (/feed/)                    { say 'feed CHARACTER OBJECT' }
     when (/give/)                    { say 'give CHARACTER OBJECT' or say 'give OBJECT to CHARACTER' }
     when (/light/)                   { say 'light OBJECT' }
     when (/wear/)                    { say 'wear OBJECT' }
     when (/smell/)                   { say 'wear OBJECT' }
     when (/pickup|drop|throw/)       { say 'use OBJECT' }
     when (/fight|attack|punch|kill/) { say 'fight CHARACTER' }
     when (/whack|hit/)               { say 'hit CHARACTER with OBJECT' }
     default                          { say 'Thats not fair' }
  }
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

   # perform
   $player->location_object->get_actor($$ra_words[2])->use_action($$ra_words[0]);

   return;

   $player->location_object->put_item('fishpole', $player);
   $player->location_object->use_exit('Out');
   $player->location_object->use_exit('North');
   $player->location_object->use_exit('Up');
   $player->location_object->put_item('branch', $player);
   $player->location_object->use_exit('Down');
   $player->location_object->use_exit('South');
   $player->location_object->use_exit('South');
   $player->location_object->use_action('fish');
   $player->location_object->use_exit('North');
   $player->location_object->use_exit('North');
   $player->location_object->use_exit('East');
   Adventure->get_actor('troll')->use_action('give troll fish');
   $player->location_object->use_exit('East');
   Adventure->get_actor('guard')->use_action('hit guard with branch');
   $player->location_object->get_actor('koguard')->put_item('key', $player);
   $player->location_object->use_exit('East');
   $player->location_object->put_item('candle', $player);
   $player->location_object->use_exit('West');
   $player->location_object->use_exit('Down');
   $player->get_item_object('unlitlamp')->use_action('light');
   $player->location_object->use_exit('Down');
   $player->get_item_object('candle')->use_action('light');
   $player->location_object->put_item('crown', $player);
   $player->location_object->use_exit('Up');
   $player->location_object->use_exit('Up');
   $player->location_object->use_exit('Up');
   $player->location_object->use_exit('Up');
   $player->get_item_object('key')->use_action('unlock tower door');
   $player->location_object->use_exit('Up');
   $player->location_object->get_actor('sadprincess')->use_action('give rose');

   $player->location_object->get_actor('happyprincess')->use_action('marry');
   $player->location_object->use_exit('Down');
   $player->location_object->use_exit('Down');
   $player->location_object->use_exit('East');
   $player->location_object->use_exit('East');
#   $player->location_object->get_actor('throne')->use_action('sit');
 

   say $player->location;

   if (not ($player->location_object->has_actor($$ra_words[2]) ) ) {
      $player->announce('Location does not have that'); return;
   }

   # find out if 'sit' is an available action for this actor
   if ( not ($player->location_object->get_actor($$ra_words[2])->has_action($$ra_words[0]) ) ) {
      $player->announce('your SIT sentence sux'); return;
   }

   # perform
   $player->location_object->get_actor($$ra_words[2])->use_action($$ra_words[0]);

   return;
}
