use strict;
use warnings;
package Adventure::Command;
use feature 'say';
use Text::ParseWords;
use Moo;
use experimental 'smartmatch';
use Ouch;

# old Steve stuff. Maybe in the refactoring part N
#sub process_command {
#  my ($self, $line) = @_;
#
#  my @words = parse_line( '\s+', 0, $line );
#
#  my $verb = shift @words;
#
#  my %util_verb_list =  
#      (score      => UtilScore, 
#       status     => UtilStatus, 
#       inventory  => UtilInv, 
#       show       => UtilShow, 
#       exit       => UtilExit);
#
#  # First thing to check is utility words
#  if ( $util_verb_list{$verb}  ) {
#     # Then do the util thing.
#  } 
#  elsif ( $pers_verb_list{$verb}  ) {
#     # Then do the util thing.
#  } 
#
#  # Personal actions  (score status inventory show exit)
#  # Actor actions     (eg., look [actor] sit pick kiss hit talk take give)
#   # Eg., "give fish" means "give troll fish" if there is a troll.
#  # Item actions      (eg., look [thing] light [candle])
#  # Location actions  (eg., look go jump fish take drop)
#  my @location_verb_list = qw(go fish jump);
#
#  # Next thing to check is any recognized words
#  if ( $verb ~~ @location_verb_list ) {
#  }
#
#}

sub cmd_attack { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'fight CHARACTER';
   return;
}

sub cmd_fight  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'fight CHARACTER';
   return;
}
sub cmd_punch  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'fight CHARACTER';
   return;
}
sub cmd_kill   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'fight CHARACTER';
   return;
}

sub cmd_cast   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'cast fishpole';
   return;
}
sub cmd_go     { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'go fishing';
   return;
}
sub cmd_use    { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'cast fishpole';
   return;
}

sub cmd_exit   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'exit'; 
   $player->game_over(); 
   return;
}

sub cmd_feed   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'feed CHARACTER OBJECT';
   return;
}

sub cmd_give   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'give CHARACTER OBJECT  OR  give OBJECT to CHARACTER';
   return;
}

sub cmd_hit    { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'hit CHARACTER with OBJECT';
   return;
}

sub cmd_whack  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'hit CHARACTER with OBJECT';
   return;
}

sub cmd_jump   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'you can only jump out of a tree';
   return;
}

sub cmd_kiss   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'kiss CHARACTER';
   return;
}

sub cmd_light  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'light OBJECT'; 
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your LIGHT sentence sux'); return;
   }

   if ( not ($player->has_item($$ra_words[1]) ) ) {
      $player->announce('you do not have that item'); return;
   }
   $player->get_item_object($$ra_words[1])->use_action('light');
   return;
}

sub cmd_move   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'move DIRECTION'; 
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your MOVE sentence sux'); return;
   }

   # will Adventure->player->announce('There is no exit named '.$exit.'.')
   #
   # JT empowered the 'directions' to be first letter upper case
   # in the yaml definition and did not want use to change it!???
   # This is not a bug. Its a FEATURE.
   $player->location_object->use_exit("\u$$ra_words[1]");
   return; 
}

sub cmd_pickup { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'pickup OBJECT'; 
   if ( not (scalar @$ra_words) == 2 ) {
      $player->announce('your PICKUP sentence sux'); return;
   }

   if (not ($player->location_object->has_item($$ra_words[1]) ) ) {
      $player->announce('Location does not have that'); return;
   }

   $player->location_object->put_item($$ra_words[1], $player);
   return;
}

sub cmd_throw  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'pickup OBJECT';
   return;
}
sub cmd_drop   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'drop OBJECT';
   return;
}

sub cmd_show   {
   my ($this, $game, $player, $ra_words) = @_;
   say 'show stuff';
   return;
}

sub cmd_sit    { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'sit on OBJECT'; 
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
sub cmd_smell  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'smell OBJECT';
   return;
}

sub cmd_take   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'take OBJECT from CHARACTER'; 
   return;
}

sub cmd_unlock { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'unlock tower door';
   return;
}

sub cmd_wear   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'wear OBJECT';
   return;
}

1;
