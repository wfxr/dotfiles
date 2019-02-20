#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

gem install pry
gem install rubocop
gem install bundler

ln -sf "$SCRIPT_DIR"/rubocop.yml ~/.rubocop.yml
