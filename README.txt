Game still underconstruction!

At the current time
   $ cd perl5
   $ perl  tcmd.pl

   There is 
       help     # list of commands
       show     # shows all current info INVENTORY|ITEMS|EXITS|ACTORS

For a map of ActionCastle game. Those developers forget what their doing after a time off the gig.
   perl5/ActionCastleMap.pdf

Current testing via non t\*.t files
   $ perl  tcmd.pl  input.txt

To test commands in a certain location in the game
   $ cp input.txt my-new-stuff.txt

   Edit your file. Remove the stuff you don't want
   $ vi my-new-stuff.txt

   # with the dash, '-', you're telling perl you want to input more stuff to the game
   $ perl  tcmd.pl  my-new-stuff.txt  -

Enjoy!
