import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// Platform helper that works across web and native platforms
class PlatformHelper {
  /// Returns true if running on web
  static bool get isWeb => kIsWeb;

  /// Returns true if running on iOS (always false on web)
  static bool get isIOS {
    if (kIsWeb) return false;
    return _nativeIsIOS;
  }

  /// Returns true if running on Android (always false on web)
  static bool get isAndroid {
    if (kIsWeb) return false;
    return _nativeIsAndroid;
  }

  /// Returns true if running on macOS (always false on web)
  static bool get isMacOS {
    if (kIsWeb) return false;
    return _nativeIsMacOS;
  }

  /// Returns true if running on Windows (always false on web)
  static bool get isWindows {
    if (kIsWeb) return false;
    return _nativeIsWindows;
  }

  /// Returns true if running on Linux (always false on web)
  static bool get isLinux {
    if (kIsWeb) return false;
    return _nativeIsLinux;
  }

  /// Returns true if running on a mobile platform (iOS or Android)
  static bool get isMobile => isIOS || isAndroid;

  /// Returns true if running on a desktop platform (macOS, Windows, or Linux)
  static bool get isDesktop => isMacOS || isWindows || isLinux;
}

// These getters are only called when kIsWeb is false
bool get _nativeIsIOS {
  return _getPlatformOperatingSystem() == 'ios';
}

bool get _nativeIsAndroid {
  return _getPlatformOperatingSystem() == 'android';
}

bool get _nativeIsMacOS {
  return _getPlatformOperatingSystem() == 'macos';
}

bool get _nativeIsWindows {
  return _getPlatformOperatingSystem() == 'windows';
}

bool get _nativeIsLinux {
  return _getPlatformOperatingSystem() == 'linux';
}

String _getPlatformOperatingSystem() {
  // This uses defaultTargetPlatform which is safe on all platforms
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return 'ios';
    case TargetPlatform.android:
      return 'android';
    case TargetPlatform.macOS:
      return 'macos';
    case TargetPlatform.windows:
      return 'windows';
    case TargetPlatform.linux:
      return 'linux';
    case TargetPlatform.fuchsia:
      return 'fuchsia';
  }
}
