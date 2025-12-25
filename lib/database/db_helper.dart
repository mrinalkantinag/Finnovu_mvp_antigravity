
// Conditionally import the correct file based on the platform
// If dart.library.io is available (Mobile/Desktop), use db_native.dart
// If dart.library.html (Web) is available, use db_web.dart

export 'db_native.dart' if (dart.library.html) 'db_web.dart';
