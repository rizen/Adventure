package My::Test::Class;
use strict;
use warnings;
use Test::Class::Moose;
with 'Test::Class::Moose::Role::AutoUse';

our $VERSION = '0.01';

1;
__END__
=head1 Name

TestsFor.pm

=head1 VERSION

VERSION 0.01

=head1 SYNOPSIS

Base Class for a Test::Class::Moose test suite used by parent modules.
use Test::Class::Moose parent => 'My::Test::Class';

=head1 DESCRIPTION

Base Class for other Test::Class::Moose parent modules to inherit.

=head1 BUGS

No Features to report

=head1 AUTHOR

James Edwards

=head1 LICENSE

Ya Right

=cut
