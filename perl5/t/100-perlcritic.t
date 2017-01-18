use strict;
use warnings;
use Test::More;

our $VERSION = '0.01';

## no critic
eval 'use Test::Perl::Critic';
plan skip_all => 'Test::Perl::Critic required' if $@;

# NOTE: New files will be tested automatically.
#use Perl::Critic::Moose;

# FIXME: Things should be removed (not added) to this list.
# Temporarily skip any files that existed before adding the tests.
# Eventually these should all be removed (once the files are cleaned up).
#my %skip = map { ( $_ => 1 ) } qw( t/etc/schema.pl );
my %skip = map { ( $_ => 1 ) } qw( );

#my @files = grep { !$skip{$_} } ( Perl::Critic::Utils::all_perl_files(qw( Makefile.PL bin lib t )) );
my @files =
  grep { !$skip{$_} }
    ( Perl::Critic::Utils::all_perl_files(qw( lib t )) );

    foreach my $file (@files) {
        critic_ok( $file, $file );
        }
done_testing();
