import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';

class FirebaseInitializer {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;
    } on FirebaseException catch (error, stackTrace) {
      // Surface Firebase boot errors to the app startup UI and tests.
      debugPrint('Firebase initialization failed: ${error.message}');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    } catch (error, stackTrace) {
      debugPrint('Unexpected startup error: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }
}
