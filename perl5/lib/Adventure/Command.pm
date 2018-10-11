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
   # guard: attack, punch
   my ($this, $game, $player, $ra_words) = @_;
   say 'attack Actor';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub fight {
   my ($this, $game, $player, $ra_words) = @_;
   if (not ($player->location_object->has_actor($$ra_words[1]) ) ) {
      $player->announce("Location does not have that:" . $$ra_words[1]); return;
   }
   $player->location_object->get_actor($$ra_words[1])->use_action("fight $$ra_words[1]");
   return;
}

sub cmd_fight  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'fight Actor';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   $this->fight( $game, $player, $ra_words);
   return;
}
sub cmd_punch  { 
   # guard: attack, punch
   my ($this, $game, $player, $ra_words) = @_;
   say 'punch/fight Actor';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub cmd_kill   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'kill/fight Actor';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub cmd_cast   { 
   my ($this, $game, $player, $ra_words) = @_;
#   say 'cast fishpole';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[2] sentence sux"); return;
   }
   if ( not ($player->has_item($$ra_words[1]) ) ) {
      $player->announce('you do not have that item'); return;
   }
   $player->location_object->use_action('fish');
   return;
}
sub cmd_go     { 
   my ($this, $game, $player, $ra_words) = @_;
#   say 'go fishing';
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce("your \u${$ra_words}[2] sentence sux"); return;
   }
   if ($$ra_words[1] ne 'fishing') {
      $player->announce("You can only 'go fishing' with a fishpole"); return;
   }
   if ( not ($player->has_item('fishpole')) ) {
      $player->announce('you do not have that item'); return;
   }
   $player->location_object->use_action('fish');
   return;
}
sub cmd_use    { 
   my ($this, $game, $player, $ra_words) = @_;
#   say 'use fishpole';
   $this->cmd_cast( $game, $player, $ra_words);
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
#   say 'feed CHARACTER OBJECT';
   if ( not ((scalar @$ra_words) == 3) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   if (not ($player->location_object->has_actor($$ra_words[1]) ) ) {
      $player->announce("Location does not have that:" . $$ra_words[1]); return;
   }
   if ( not ($player->has_item($$ra_words[2]) ) ) {
      $player->announce('you do not have that item'); return;
   }
   my $str1 = "$$ra_words[1] $$ra_words[2]";
   my $str2 = "give $str1";
#   my $ra = Adventure->get_actor($$ra_words[1])->available_actions;
   my $ra = $game->get_actor($$ra_words[1])->available_actions;
 
#   my $rc = Adventure->get_actor($$ra_words[1])->has_action($str2);

#   if (not(Adventure->get_actor($$ra_words[1])->has_action($str2))) {
   if (not($game->get_actor($$ra_words[1])->has_action($str2))) {
      $player->announce("There is NO action named feed $str1"); return;
   }
#   Adventure->get_actor($$ra_words[1])->use_action('give troll fish');
#   Adventure->get_actor($$ra_words[1])->use_action($str2);
   $game->get_actor($$ra_words[1])->use_action($str2);
   return;
}

sub cmd_give   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'give CHARACTER OBJECT  OR  give OBJECT to CHARACTER';
   $$ra_words[0] = 'feed';
   $this->cmd_feed($game, $player, $ra_words);
   return;
}

sub cmd_hit    { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'hit CHARACTER with OBJECT';
   if ( not ((scalar @$ra_words) == 4) ) {
      $player->announce("your \u${$ra_words}[0] sentence sux"); return;
   }
   if (not ($player->location_object->has_actor($$ra_words[1]) ) ) {
      $player->announce("Location does not have that:" . $$ra_words[1]); return;
   }
   if ( not ($player->has_item($$ra_words[3]) ) ) {
      $player->announce('you do not have that item'); return;
   }
   my $str = "hit $$ra_words[1] with $$ra_words[3]";
   $game->get_actor('guard')->use_action($str);
   $player->location_object->get_actor('koguard')->put_item('key', $player);
   return;
}

sub cmd_whack  { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'hit CHARACTER with OBJECT';
   $$ra_words[0] = 'hit';
   $this->cmd_hit($game, $player, $ra_words);
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
   if ( not ((scalar @$ra_words) == 2) ) {
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
#   say 'move DIRECTION'; 
   if ( not ((scalar @$ra_words) == 2) ) {
      $player->announce('your MOVE sentence sux'); return;
   }

   # will Adventure->player->announce('There is no exit named '.$exit.'.')
   #
   # JT empowered the 'directions' to be first letter upper case
   # in the yaml definition and did not want use to change it!?
   # This is not a bug. Its a FEATURE.
   #
   $player->location_object->use_exit("\u$$ra_words[1]");
   say 'you are at the ', $player->location;
   return; 
}

sub cmd_cd {
   my ($this, $game, $player, $ra_words) = @_;
   $this->cmd_move($game, $player, $ra_words);
}


sub cmd_pickup { 
   my ($this, $game, $player, $ra_words) = @_;
#   say 'pickup OBJECT'; 
   if ( not ((scalar @$ra_words) == 2) ) {
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
   say 'show all';
   # NOT DONE
   say "I have : ";
   $player->display_inventory;
   say '';
   say 'Location: ', $player->location;
   print "   Items-: "; 
   for (keys %{$player->location_object->items}) { print; }
   say '';
   say "   Exits-: ", "@{$player->location_object->available_exits}";
   say "   Actors: ", "@{$player->location_object->actors}";
   return;
}

sub cmd_ls   {
   my ($this, $game, $player, $ra_words) = @_;
   $this->cmd_show($game, $player, $ra_words);
   return;
}

sub cmd_sit    { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'sit on OBJECT'; 
   if ( not ((scalar @$ra_words) == 3) ) {
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
    $player->get_item_object('key')->use_action('unlock tower door');
   return;
}

sub cmd_wear   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'wear OBJECT';
   return;
}

sub cmd_marry   { 
   my ($this, $game, $player, $ra_words) = @_;
   say 'marry CHARACTER';
   $player->location_object->get_actor('happyprincess')->use_action('marry');
   return;
}

1;
