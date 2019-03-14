Here are the notes for how we did plugins

~/missions/PROJECT.yaml
~/missions/actioncastle.yaml
> namespace : ActionCastle

 ~/perl5/lib/Adventure/Module/NAMESPACE
 ~/perl5/lib/Adventure/Module/ActionCastle

There are currently 3 type of plugins folders (Actions, Exits, Turns)

$ tree
├── Action
│   ├── GiveRose.pm
│   ├── GoFishing.pm
│   ├── HitWithBranch.pm
│   ├── KillPlayer.pm
│   ├── LightCandle.pm
│   ├── LightLamp.pm
│   ├── Propose.pm
│   ├── SitThrone.pm
│   ├── TakeItem.pm
│   ├── TrollIsFed.pm
│   └── UnlockDoor.pm
├── Exit
│   └── Blocked.pm
└── Turn
    ├── ReceiveCommand.pm
    └── TrollRage.pm

Actions -> definitions in yaml
   > locations:
   >     LOCATION:
   >         name: Long location name
   >         description : Message to user about the location
   >        ...
   >        actions :
   >            ACTION :
   >                code : GoFishing

   ~/perl5/Adventure/lib/Adventure/Role/Actions.pm
   > after init => sub {
   >     my ($self, $key, $config) = @_;
   >     $self->install_plugin($key, $config, {
   >         type        => 'actions',
   >         namespace   => 'Action',
   >     });
   > };


Exits -> definitions in yaml
   > locations:
   >     LOCATION:
   >         name: Long location name
   >         description : Message to user about the location
   >         exits :
   >             EXIT :
   >                 code : Blocked
   >                 params :
   >                     destination : courtyard
   >                     allow_property : troll_fed
   >                     description : There is a mean troll in the way!

   ~/perl5/Adventure/lib/Adventure/Location.pm
   > after init => sub {
   >     my ($self, $key, $config) = @_;
   >     # commenting out for now, will put back sometime... -sk.
   >      # warn "need to implement LOOK for $key. should that just be an action?";
   >     if (ref $config eq 'HASH') {
   >         if (exists $config->{actors}) {
   >             if (ref $config->{actors} eq 'ARRAY') {
   >                 $self->add_actors($config->{actors});
   >             }
   >             else {
   >                 die "$key actors must be an array";
   >             }
   >         }
   >         $self->install_plugin($key, $config, {
   >             type        => 'exits',
   >             namespace   => 'Exit',
   >         });
   >     }
   > };


Turns -> definition in yaml
   > player:
   >     end_turn_events :
   >         troll rage:
   >             code: TrollRage

   ~/perl5/Adventure/lib/Adventure/Player.pm
   > after init => sub {
   >     my ($self, $key, $config) = @_;
   >     $self->add_aliases(['self','myself']);
   >     $self->install_plugin($key, $config, {
   >         type        => 'start_turn_events',
   >         namespace   => 'Turn',
   >     });
   >     $self->install_plugin($key, $config, {
   >         type        => 'end_turn_events',
   >         namespace   => 'Turn',
   >     });
   >     $self->location($config->{location});
   > };

 
