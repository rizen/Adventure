use v5.20;
use Test::More;
use FindBin::libs;













my @testz   = 
(
   [ 
     [ use_exit => $exit      ],
   ], 
   [ 
     [ 'location'           ],
     [ $loc                 ],
     [ "Location is '$loc'" ]
   ], 
);

SKIP:
{
    use_ok 'Adventure'   or skip "Un-usable: 'Adventure'"    => 1;
    -e $path             or skip "Non-existant: '$path'"     => 1;
    -r _                 or skip "Non-readable: '$path'"     => 1;
    -s _                 or skip "Zero-sized: '$path'"       => 1;
     
    my $player
    = eval
    {
        Adventure->init( $path );
        Adventure->player
    }
    ? pass "Completed init '$path'"
    : skip "Failed execution: $@"   => 1
    ;

    $player->$exercise( @testz x 10_000 );
};

# this is not a module
0
__END__
