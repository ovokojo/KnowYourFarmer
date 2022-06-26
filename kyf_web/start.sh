#!/bin/bash
export PATH="$PATH:/Users/thomaskojoaddaquay/code/ovokojo/flutter/bin"
dart pub global activate fvm
export PATH="$PATH":"$HOME/.pub-cache/bin"
fvm use 2.10.2
flutter run -d chrome --web-renderer html