#!/bin/bash
set -e

FLUTTER_DIR="$HOME/flutter"
export PATH="$FLUTTER_DIR/bin:$PATH"

flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter build web --release --dart-define=ENV=prod