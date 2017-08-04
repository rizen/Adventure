package TestsFor::Adventure::Actor;
use strict;
use warnings;
use Test::Class::Moose extends => 'TestsFor::Adventure::Base';
use namespace::autoclean;
use DateTime;

our $VERSION = '0.01';

=head1 Name

TestsFor::Adventure::Actor.pm

=head1 VERSION

VERSION 0.01

=head1 SYNOPSIS

Is used by Test::Class::Moose Base Class to test the Adventure::Actor object.

=head1 DESCRIPTION

todo

=head1 METHODS

=head2 test_after_init

warn "NEED to implement TALK for $key";

=cut

sub test_after_init : {
   my $test = shift;
   $test->test_report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'init';
   return;
}

=head2 test_attributes

Test those attributes

=cut

sub test_attributes : {
   my $test = shift;
   $test->test_report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'key';
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
