package TestsFor::Adventure::Location;
use strict;
use warnings;
use Test::Class::Moose extends => 'TestsFor::Adventure::Base';
use namespace::autoclean;
use DateTime;

our $VERSION = '0.01';

=head1 Name

TestsFor::Adventure::Location.pm

=head1 VERSION

VERSION 0.01

=head1 SYNOPSIS

Is used by Test::Class::Moose Base Class to test the Adventure::Location object.

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
   $test->test_report->plan(8);
   my $obj = $test->test_obj;

   can_ok $obj, 'add_exits';
   can_ok $obj, 'add_exit';
   can_ok $obj, 'available_exits';
   can_ok $obj, 'use_exit';
   can_ok $obj, 'add_actors';
   can_ok $obj, 'add_actor';
   can_ok $obj, 'remove_actor';
   can_ok $obj, 'has_actor';
   can_ok $obj, 'replace_actor';

   return;
}

=head2 test_attributes

Test those attributes

=cut

sub test_attributes : {
   my $test = shift;
   $test->test_report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'exits';
   can_ok $obj, 'actors';
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
