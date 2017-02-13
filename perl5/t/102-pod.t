use strict;
use warnings;
use Test::More;
use English;

our $VERSION = '0.01';

# Stolen from Catalyst MVC project generator output

plan skip_all => 'set TEST_POD to enable this test' unless $ENV{TEST_POD};
eval 'use Test::Pod 1.14';
plan skip_all => 'Test::Pod 1.14 required' if $EVAL_ERROR;

all_pod_files_ok();
