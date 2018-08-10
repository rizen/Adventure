use strict;
use warnings;
package Adventure::Item;
use Moo;
extends 'Adventure::Base';
with 'Adventure::Role::Thing';
with 'Adventure::Role::Aliases';
with 'Adventure::Role::Properties';
with 'Adventure::Role::Actions';

sub init { $_[0]->SUPER::init }

1;
