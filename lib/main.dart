import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'routes/app_router.dart';
import 'firebase/firebase_initializer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter framework error: ${details.exceptionAsString()}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught platform error: $error');
    debugPrintStack(stackTrace: stack);
    return true;
  };

  runZonedGuarded(
    () => runApp(const ProviderScope(child: ReviewFlowApp())),
    (error, stack) {
      debugPrint('Uncaught zone error: $error');
      debugPrintStack(stackTrace: stack);
    },
  );
}

class ReviewFlowApp extends ConsumerWidget {
  const ReviewFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'ReviewFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: AppRouter.router,
      builder: (context, child) => AppStartupGate(
        initializeApp: FirebaseInitializer.initialize,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

class AppStartupGate extends StatefulWidget {
  const AppStartupGate({
    super.key,
    required this.initializeApp,
    required this.child,
  });

  final Future<void> Function() initializeApp;
  final Widget child;

  @override
  State<AppStartupGate> createState() => _AppStartupGateState();
}

class _AppStartupGateState extends State<AppStartupGate> {
  late Future<void> _startupFuture;

  @override
  void initState() {
    super.initState();
    _startupFuture = widget.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _startupFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _StartupLoadingView();
        }

        if (snapshot.hasError) {
          return _StartupErrorView(
            error: snapshot.error,
            onRetry: () {
              setState(() {
                _startupFuture = widget.initializeApp();
              });
            },
          );
        }

        return widget.child;
      },
    );
  }
}

class _StartupLoadingView extends StatelessWidget {
  const _StartupLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Initializing ReviewFlow...'),
          ],
        ),
      ),
    );
  }
}

class _StartupErrorView extends StatelessWidget {
  const _StartupErrorView({
    required this.error,
    required this.onRetry,
  });

  final Object? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Startup failed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '$error',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'ReviewFlow Running Successfully',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}*/
