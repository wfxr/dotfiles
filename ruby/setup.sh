#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
gem install pry
