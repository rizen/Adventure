#!/bin/bash
export HARNESS_PERL_SWITCHES=-MDevel::Cover
export TEST_POD=1
cover -delete
prove -lv --merge t
cover
