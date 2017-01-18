#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use English;

our $VERSION = qw(0.01);

# Stolen from Catalyst MVC project auto generated

plan skip_all => 'set TEST_POD to enable this test' unless $ENV{TEST_POD};

eval 'use Test::Pod::Coverage 1.04';
plan skip_all => 'Test::Pod::Coverage 1.04 required' if $EVAL_ERROR;

eval 'use Pod::Coverage 0.20';
plan skip_all => 'Pod::Coverage 0.20 required' if $EVAL_ERROR;

all_pod_coverage_ok();
