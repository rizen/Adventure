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

sub CorrectLengthOfCmd { my ( $player, $cmd, $ra_words, $length ) = @_;

   return 1 if ( (scalar @$ra_words) == $length);
   $player->announce("your $cmd sentence sux"); 
   return 0;
}

sub ActorAtLocation { my ( $player, $character ) = @_;
   return 1 if ($player->location_object->has_actor($character) );
   $player->announce("Location does not have that $character"); return;
   return 0;
}

sub ActorHasAction { my ( $game, $player, $character, $action ) = @_;
   return 1 if ($game->get_actor($character)->has_action($action));
   $player->announce("There is NO action $action for $character");
   return 0;
}

sub ItemActorAtLocation { my ( $player, $item ) = @_;
   return 1 if ($player->location_object->has_actor($item) );
   $player->announce("Location does not have that $item");
   return 0;
}

sub ActorHasItem { my ( $game, $player, $character, $item ) = @_;
   return 1 if ($game->get_actor($character)->has_item($item));
   $player->announce("There is NO $item for $character");
   return 0;
}

sub LocationHasItem { my ( $player, $item ) = @_;
   
   return 1 if ($player->location_object->has_item($item)  );
   $player->announce('Location does not have that $item');
   return 0;
}

sub PlayerHasItem { my ( $player, $item ) = @_;
   return 1 if ( $player->has_item($item) );
   $player->announce("you do not have that $item");
   return 0;
}

sub cmd_attack { my ($this, $game, $player, $ra_words) = @_; 
   # guard: attack, punch
   my ($cmd, $character) = @{$ra_words};
   say 'attack Actor';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub fight { my ($this, $game, $player, $ra_words) = @_; 
   my ($cmd, $character) = @{$ra_words};

   return if ( not (ActorAtLocation($player, $character))); 

   $player->location_object->get_actor($character)->use_action("fight $character");
   return;
}

sub cmd_fight { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character) = @{$ra_words};
   say 'fight Actor';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   $this->fight( $game, $player, $ra_words);
   return;
}

sub cmd_punch { my ($this, $game, $player, $ra_words) = @_;
   # guard: attack, punch
   my ($cmd, $character) = @{$ra_words};
   say 'punch/fight Actor';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub cmd_kill { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character) = @{$ra_words};
   say 'kill/fight Actor';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   $$ra_words[0] = 'fight';
   $this->fight( $game, $player, $ra_words);
   return;
}

sub cmd_cast { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $object) = @{$ra_words};
#   say 'cast fishpole';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   return if ( not (PlayerHasItem($player,$object)));

   $player->location_object->use_action('fish');
   return;
}

sub cmd_go { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $action) = @{$ra_words};
#   say 'go fishing';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   if ($action ne 'fishing') {
      $player->announce("You can only 'go fishing' with a fishpole"); return;
   }

   return if ( not (PlayerHasItem($player, 'fishpole')));

   $player->location_object->use_action('fish');
   return;
}

sub cmd_use { my ($this, $game, $player, $ra_words) = @_;
#   say 'use fishpole';
   $this->cmd_cast( $game, $player, $ra_words);
   return;
}

sub cmd_exit { my ($this, $game, $player, $ra_words) = @_;
   $player->game_over(); 
   return;
}

sub cmd_feed { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character, $item) = @{$ra_words};
#   say 'feed CHARACTER OBJECT';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 3)));

   return if ( not (ActorAtLocation($player, $character))); 

   return if ( not (PlayerHasItem($player,$item)));

   my $str1 = "$character $item";
   my $str2 = "give $str1";
 
   if ( not($game->get_actor($character)->has_action($str2))) {
      $player->announce("There is NO action named feed $str1"); return;
   }
   $game->get_actor($character)->use_action($str2);
   return;
}

sub cmd_give { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character, $item) = @{$ra_words};
   say 'give CHARACTER OBJECT  OR  give OBJECT to CHARACTER';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 3)));

   return if ( not (ActorAtLocation($player, $character))); 

   return if ( not (PlayerHasItem($player,$item)));

   my $str = "give $item";
   if ( not($game->get_actor($character)->has_action($str))) {
      $player->announce("There is NO action named give $character $item"); return;
   }
   $game->get_actor($character)->use_action($str);
   return;
}

sub cmd_hit { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character, $dummy, $item) = @{$ra_words};
   say 'hit CHARACTER with OBJECT';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 4)));

   return if ( not (ActorAtLocation($player, $character))); 

   return if ( not (PlayerHasItem($player,$item)));

   my $str = "hit $character with $item";
   if ( not($game->get_actor($character)->has_action($str))) {
      $player->announce("There is NO action named $str"); return;
   }
   $game->get_actor($character)->use_action($str);
   $player->announce('guard is now koguard');
   return;
}

sub cmd_whack { my ($this, $game, $player, $ra_words) = @_;
   say 'hit CHARACTER with OBJECT';
   $$ra_words[0] = 'hit';
   $this->cmd_hit($game, $player, $ra_words);
   return;
}

sub cmd_jump { my ($this, $game, $player, $ra_words) = @_;
   say 'you can only jump out of a tree';
   return;
}

sub cmd_kiss { my ($this, $game, $player, $ra_words) = @_;
   say 'kiss CHARACTER';
   return;
}

sub cmd_light { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $item) = @{$ra_words};
   say 'light OBJECT'; 

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   return if ( not (PlayerHasItem($player,$item)));

   $player->get_item_object($item)->use_action('light');
   return;
}

sub cmd_move { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $direction) = @{$ra_words};
#   say 'move DIRECTION'; 

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   # will Adventure->player->announce('There is no exit named '.$exit.'.')
   #
   # JT empowered the 'directions' to be first letter upper case
   # in the yaml definition and did not want use to change it!?
   # This is not a bug. Its a FEATURE.
   #
   $player->location_object->use_exit("\u$direction");
   say 'you are at the ', $player->location;
   return; 
}

sub cmd_cd { my ($this, $game, $player, $ra_words) = @_;
   $this->cmd_move($game, $player, $ra_words);
}


sub cmd_pickup { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $item) = @{$ra_words};
#   say 'pickup OBJECT'; 

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   return if ( not (LocationHasItem($player,$item)) );

   $player->location_object->put_item($item, $player);
   return;
}

sub cmd_throw { my ($this, $game, $player, $ra_words) = @_;
   say 'pickup OBJECT';
   return;
}
sub cmd_drop { my ($this, $game, $player, $ra_words) = @_;
   say 'drop OBJECT';
   return;
}

sub cmd_show { my ($this, $game, $player, $ra_words) = @_;
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

sub cmd_ls { my ($this, $game, $player, $ra_words) = @_;
   $this->cmd_show($game, $player, $ra_words);
   return;
}

sub cmd_sit { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $dummy, $item) = @{$ra_words};
   say 'sit on OBJECT'; 

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 3)));

   return if ( not (ItemActorAtLocation($player, $item))); 

   $player->location_object->get_actor($item)->use_action($cmd);
   return;
}

sub cmd_smell { my ($this, $game, $player, $ra_words) = @_;
   say 'smell OBJECT';
   return;
}

sub cmd_take { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $item, $dummy, $character) = @{$ra_words};
   say 'take OBJECT from CHARACTER'; 

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 4)));

   return if ( not (ActorAtLocation($player, $character))); 

   return if ( not (ActorHasItem($game, $player, $character, $item)));

   $player->location_object->get_actor($character)->put_item($item, $player);
   return;
}

sub cmd_unlock { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $location, $item) = @{$ra_words};
   say 'unlock tower door';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 3)));

   return if ( not (ItemActorAtLocation($player, $item))); 

   $player->get_item_object('key')->use_action("$cmd $location $item");
   return;
}

sub cmd_wear { my ($this, $game, $player, $ra_words) = @_;
   say 'wear OBJECT';
   return;
}

sub cmd_marry { my ($this, $game, $player, $ra_words) = @_;
   my ($cmd, $character) = @{$ra_words};
   say 'marry CHARACTER';

   return if ( not (CorrectLengthOfCmd($player, $cmd, $ra_words, 2)));

   return if ( not (ActorAtLocation($player, $character))); 

   return if ( not (ActorHasAction( $game, $player, $character, 'marry')));

   $player->location_object->get_actor($character)->use_action('marry');
   return;
}

1;
