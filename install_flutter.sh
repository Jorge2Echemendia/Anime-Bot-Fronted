#!/bin/bash
set -e

FLUTTER_VERSION="3.35.7"
FLUTTER_DIR="$HOME/flutter"

if [ -d "$FLUTTER_DIR" ]; then
  echo "Actualizando Flutter existente a $FLUTTER_VERSION..."
  cd "$FLUTTER_DIR"
  git fetch --tags
  git checkout "$FLUTTER_VERSION"
  git pull
  cd ..
else
  echo "Clonando Flutter $FLUTTER_VERSION..."
  git clone https://github.com/flutter/flutter.git --branch stable "$FLUTTER_DIR"
  cd "$FLUTTER_DIR"
  git checkout "$FLUTTER_VERSION"
  cd ..
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
flutter doctor
flutter clean
flutter config --enable-web
flutter pub get