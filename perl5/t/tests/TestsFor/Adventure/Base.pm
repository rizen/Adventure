package TestsFor::Adventure::Base;
use strict;
use warnings;
use Test::Class::Moose parent => 'My::Test::Class';
use namespace::autoclean;

has test_obj => ( is => 'rw', isa => 'Adventure::Base' );

our $VERSION = '0.01';

=head1 Name

TestsFor::Adventure::Base.pm

=head1 VERSION

VERSION 0.01

=head1 SYNOPSIS

Is used by Test::Class::Moose Base Class to test the Adventure::Base object.

=head1 DESCRIPTION

Test suite to test the attributes of the Adventure::Base Object

=head1 METHODS

=head2 constructor_args

A private sub routine to set up arguments to create a default test Adventure::Base

=cut

sub constructor_args {
    return (
    );
}

=head2 test_setup

1) Will execute the Base Class's test_startup sub routine (if it exists!).
2) Will create a class method "default_object" for Adventure

=cut

sub test_setup {
    my ( $test, $report ) = @_;
    $test->next::method($report);    # call parent method
    $test->test_obj(
        $test->class_name->new( { $test->constructor_args, } ) );
    return;
}

=head2 test_startup

Boilerplate sub routine if we needed to use a RDBMS

=cut

sub test_startup {
    return;
}

=head2 test_shutdown

Boilerplate sub routine if we needed to use a RDBMS

=cut

sub test_shutdown {
    return;
}

=head2 test_teardown

Boilerplate sub routine if we needed to use a RDBMS

=cut

sub test_teardown { }

sub test_constructor : Tests(2) {

    #sub test_constructor {
    my ( $test, $report ) = @_;

    #    $report->plan(3);
    ok my $obj = $test->test_obj, 'We should have a test Adventure::Base';

    isa_ok $obj, $test->class_name, '... and the object it returns';
    return;
}


sub test_method_calls {
   my ( $test, $report ) = @_;
   $report->plan(1);
   my $obj = $test->test_obj;

   can_ok $obj, 'init';

   return;
}

sub test_key {
   my ( $test, $report ) = @_;
   $report->plan(1);
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
