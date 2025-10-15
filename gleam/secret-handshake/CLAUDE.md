# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Exercism practice exercise for Gleam. The exercise implements a "Secret Handshake" decoder that converts a number (1-31) into a sequence of actions based on binary representation.

## Commands

### Testing
- Run all tests: `gleam test`
- The test runner uses Exercism's test framework with `exercism/should` assertions
- Tests are located in `test/secret_handshake_test.gleam`
- The main test entry point executes via `test_runner.main()` in the test file's `main()` function

### Building
- Build the project: `gleam build`
- Check code: `gleam check`
- Format code: `gleam format`

### Submitting
- Submit solution: `exercism submit src/secret_handshake.gleam`

## Architecture

### Core Implementation (`src/secret_handshake.gleam`)
- **Main function**: `commands(encoded_message: Int) -> List(Command)`
- **Command type**: Custom type with variants `Wink`, `DoubleBlink`, `CloseYourEyes`, `Jump`
- **Bit mapping**:
  - Bit 0 (0b1): Wink
  - Bit 1 (0b10): DoubleBlink
  - Bit 2 (0b100): CloseYourEyes
  - Bit 3 (0b1000): Jump
  - Bit 4 (0b10000): Reverse the output list
- **Implementation approach**: Uses `list.filter_map` to check each command's bitmask, then conditionally reverses based on the reverse bit

### Test Structure
- Each test function is named with `_test` suffix to be discovered by the test runner
- Tests use `should.equal` for assertions
- Tests verify individual commands, combinations, reversals, and edge cases (0 input)