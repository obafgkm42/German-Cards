#!/bin/sh

set -eu

repository_root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
test_build_directory=$(mktemp -d "${TMPDIR:-/tmp}/german-cards-structured-tests.XXXXXX")
trap 'rm -rf "$test_build_directory"' EXIT

cd "$repository_root"
xcrun swiftc \
  -parse-as-library \
  -module-cache-path "$test_build_directory/module-cache" \
  Models/GermanWord.swift \
  Services/LLMStructuredOutput.swift \
  Services/LLMWordClient.swift \
  Tests/LLMStructuredOutputTests.swift \
  -o "$test_build_directory/structured-output-tests"

"$test_build_directory/structured-output-tests"
