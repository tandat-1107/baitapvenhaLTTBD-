
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../baitap1/firebase_options.dart';
import '../baitap1/welcome_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance
          .recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (
      error,
      stack,
    ) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
  }

  runApp(const UthTodoApp());
}

class UthTodoApp extends StatelessWidget {
  const UthTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTH Todo - Firebase BT02',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3D5FE6),
        ),
        scaffoldBackgroundColor:
            const Color(0xFFF7F8FC),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Lỗi xác thực: ${snapshot.error}',
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const WelcomeScreen();
        },
      ),
    );
  }
}
