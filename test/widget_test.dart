import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reviewflow/main.dart';

void main() {
  testWidgets('App startup shows loading then app content', (
    WidgetTester tester,
  ) async {
    final completer = Completer<void>();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AppStartupGate(
            initializeApp: () => completer.future,
            child: const Text('App Ready'),
          ),
        ),
      ),
    );

    expect(find.text('Initializing ReviewFlow...'), findsOneWidget);

    completer.complete();
    await tester.pumpAndSettle();

    expect(find.text('App Ready'), findsOneWidget);
  });

  testWidgets('App startup shows error and supports retry', (
    WidgetTester tester,
  ) async {
    var attempt = 0;

    Future<void> init() async {
      attempt += 1;
      if (attempt == 1) {
        throw Exception('firebase failed');
      }
    }

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: AppStartupGate(
            initializeApp: init,
            child: const Text('App Ready'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Startup failed'), findsOneWidget);
    expect(find.textContaining('firebase failed'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.text('App Ready'), findsOneWidget);
  });

  testWidgets('ReviewFlowApp renders base shell', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ReviewFlowApp()));
    await tester.pump();

    expect(find.byType(ReviewFlowApp), findsOneWidget);
    expect(find.text('ReviewFlow'), findsOneWidget);
  });
}
