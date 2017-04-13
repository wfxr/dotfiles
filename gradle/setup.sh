#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# -p says to create the dir if it doesn't exist already.
mkdir -p ~/.gradle
ln -sf $script_dir/init.gradle ~/.gradle/init.gradle
