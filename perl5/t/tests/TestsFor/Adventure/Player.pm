package TestsFor::Adventure::Player;
use strict;
use warnings;
use Test::Class::Moose extends => 'TestsFor::Adventure::Base';
use namespace::autoclean;
use DateTime;

our $VERSION = '0.01';

=head1 Name

TestsFor::Adventure::Player.pm

=head1 VERSION

VERSION 0.01

=head1 SYNOPSIS

Is used by Test::Class::Moose Base Class to test the Adventure::Player object.

=head1 DESCRIPTION

todo

=head1 METHODS

=head2 test_after_init

Temporary subroutine to start testing

=cut

sub test_after_init : {
   my $test = shift;
   $test->test_report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'init';

   return;
}

=head2 test_method_calls

Temporary subroutine to start testing

=cut

sub test_method_calls : {
   my $test = shift;
   $test->test_report->plan(4);
   my $obj = $test->test_obj;

   can_ok $obj, 'location_object';
   can_ok $obj, 'announce';
   can_ok $obj, 'kill';
   can_ok $obj, 'display_score';

   return;
}

=head2 test_attributes

Test those attributes

=cut

sub test_attributes : {
   my $test = shift;
   $test->test_report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'location';
   can_ok $obj, 'score';
   return;
}

__PACKAGE__->meta->make_immutable;

1;
__END__

=head1 BUGS

No Features to report

=head1 AUTHOR

MadMongers Perl Mongers

=head1 LICENSE

Ya Right

=cut
