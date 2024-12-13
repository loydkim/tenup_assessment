import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenup_project/developer/view/developer_page.dart';

/// Quick test command: flutter test test/widget_test/dashboard_page_test.dart
/// Test on device: flutter run -t test/widget_test/dashboard_page_test.dart

void main() {
  group('Setting Page', () {
    testWidgets('Setting Page - Drag the scroll view',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const DeveloperPage()),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byKey(const Key('DeveloperPageScrollView')), findsOneWidget);
      await tester.drag(find.byKey(const Key('DeveloperPageScrollView')),
          const Offset(0.0, -500.0));
    });

    testWidgets('Setting Page - Tab Download on App store ListTile',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const DeveloperPage()),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Download on App store'), findsOneWidget);
      await tester.tap(find.byKey(Key('Download on App store')));
    });

    testWidgets('Setting Page - Tab Linked In ListTile',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: const DeveloperPage()),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byKey(const Key('DeveloperPageScrollView')), findsOneWidget);
      await tester.drag(find.byKey(const Key('DeveloperPageScrollView')),
          const Offset(0.0, -250.0));

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('LinkedIn - Youngsic Kim'), findsOneWidget);
      await tester.tap(find.byKey(Key('LinkedIn - Youngsic Kim')));
    });
  });
}
