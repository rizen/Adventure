use strict;
use warnings;
package Adventure;

=head1 NAME

Adventure - Standardize what Perl configuration Adventure uses.


=head1 SYNOPSIS

 use Adventure;

=cut

use 5.010_000;

use strict;
use warnings;

use mro     ();
use feature ();
use utf8    ();

sub import {
    warnings->import();
    warnings->unimport( qw/uninitialized/ );
    strict->import();
    feature->import( ':5.10' );
    mro::set_mro( scalar caller(), 'c3' );
    utf8->import();
}

1;
