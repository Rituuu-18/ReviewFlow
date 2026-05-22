import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reviewflow/features/dashboard/presentation/dashboard_screen.dart';
import 'package:reviewflow/main.dart';
import 'package:reviewflow/routes/app_router.dart';

void main() {
  testWidgets('Navigation flow: login to dashboard', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          builder: (context, child) => AppStartupGate(
            initializeApp: () async {},
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('ReviewFlow'), findsOneWidget);

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text('Dashboard Screen'), findsOneWidget);
  });
}
