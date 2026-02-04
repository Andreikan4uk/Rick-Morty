#!/usr/bin/env bash
set -e

echo "=== Flutter clean & pub get ==="
flutter clean
flutter pub get

echo "=== Dart analyze ==="
dart analyze --no-fatal-warnings

echo "=== Unit tests ==="
flutter test test/unit_test.dart

echo "=== Widget tests ==="
flutter test test/widget_test.dart

echo "=== Integration tests ==="
flutter test integration_test/app_test.dart

echo "=== CI finished successfully ==="