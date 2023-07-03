import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  testWidgets('Calculator button press', (WidgetTester tester) async {
    // Build the app and pump the widget tree.
    await tester.pumpWidget(MaterialApp(home: Calculator()));

    // Tap the '7' button.
    await tester.tap(find.text('7'));
    await tester.pump();

    // Verify that the output is '7' and the expression is '7'.
    expect(find.text('7'), findsOneWidget);
    expect(find.text('7'), findsNWidgets(2));

    // Tap the '+' button.
    await tester.tap(find.text('+'));
    await tester.pump();

    // Verify that the output is '0' and the expression is '7+'.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('7+'), findsOneWidget);

    // Tap the '5' button.
    await tester.tap(find.text('5'));
    await tester.pump();

    // Verify that the output is '5' and the expression is '7+5'.
    expect(find.text('5'), findsOneWidget);
    expect(find.text('7+5'), findsOneWidget);

    // Tap the '=' button.
    await tester.tap(find.text('='));
    await tester.pump();

    // Verify that the output is '12.0' and the expression is '7+5'.
    expect(find.text('12.0'), findsOneWidget);
    expect(find.text('7+5'), findsNothing);

    // Tap the '%' button.
    await tester.tap(find.text('%'));
    await tester.pump();

    // Verify that the output is '0.12' and the expression is '(12.0%)".
    expect(find.text('0.12'), findsOneWidget);
    expect(find.text('(12.0%)'), findsOneWidget);

    // Tap the 'C' button.
    await tester.tap(find.text('C'));
    await tester.pump();

    // Verify that the output is '0' and the expression is empty.
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text(''), findsOneWidget);
  });
}