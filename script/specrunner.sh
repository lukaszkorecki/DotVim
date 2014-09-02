#!/usr/bin/env bash

testToRun="$@"


bundle exec rspec $testToRun

if [[ "$?" == 0 ]] ; then
  logger -s -t RSPEC "All tests ok"
  exit 0
else
  logger -s -t RSPEC "Some tests failed!"
fi
