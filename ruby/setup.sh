#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/

sudo -H gem install pry
sudo -H gem install rubocop
sudo -H gem install bundler

ln -sf "$SCRIPT_DIR"/rubocop.yml ~/.rubocop.yml
