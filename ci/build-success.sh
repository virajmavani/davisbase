#!/bin/bash

set -ex

if [ ! -z "${GCOV}" ]; then
  # Create lcov report
  # capture coverage info
  lcov --gcov-tool "$GCOV" --directory . --capture --output-file coverage.info
  # filter out system and extra files.
  # To also not include test code in coverage add them with full path to the patterns: '*/tests/*'
  lcov --gcov-tool "$GCOV" --remove coverage.info '/usr/*' --output-file coverage.info
  # output coverage data for debugging (optional)
  lcov --gcov-tool "$GCOV" --list coverage.info
  # Uploading to CodeCov
  # '-f' specifies file(s) to use and disables manual coverage gathering and file search which has already been done above
  bash <(curl -s https://codecov.io/bash) -f coverage.info || echo "Codecov did not collect coverage reports"
fi
