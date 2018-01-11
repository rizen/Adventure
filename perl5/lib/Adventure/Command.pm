use strict;
use warnings;
package Adventure::Command;
use Text::ParseWords;
use Moo;
use experimental 'smartmatch';
use Ouch;

sub process_command {
  my ($self, $line) = @_;

  my @words = parse_line( '\s+', 0, $line );

  my $verb = shift @words;

  my %util_verb_list =  
      (score      => UtilScore, 
       status     => UtilStatus, 
       inventory  => UtilInv, 
       show       => UtilShow, 
       exit       => UtilExit);

  # First thing to check is utility words
  if ( $util_verb_list{$verb}  ) {
     # Then do the util thing.
  } 
  elsif ( $pers_verb_list{$verb}  ) {
     # Then do the util thing.
  } 

  # Personal actions  (score status inventory show exit)
  # Actor actions     (eg., look [actor] sit pick kiss hit talk take give)
   # Eg., "give fish" means "give troll fish" if there is a troll.
  # Item actions      (eg., look [thing] light [candle])
  # Location actions  (eg., look go jump fish take drop)
  my @location_verb_list = qw(go fish jump);

  # Next thing to check is any recognized words
  if ( $verb ~~ @location_verb_list ) {
  }

}

1;
