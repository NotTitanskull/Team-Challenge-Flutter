import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_dev_flutter/main.dart';

void main() {
  testWidgets('quiz supports navigation, scoring, review and restart',
      (tester) async {
    await tester.pumpWidget(const HelloWorldApp());
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<FilledButton>(
                find.widgetWithText(FilledButton, 'Finish quiz'))
            .onPressed,
        isNull);
    expect(
        tester
            .widget<TextButton>(find.widgetWithText(TextButton, 'Previous'))
            .onPressed,
        isNull);

    await tester.ensureVisible(find.text('Mars'));
    await tester.tap(find.text('Mars'));
    await tester.pumpAndSettle();
    expect(find.text('Score: 1 / 5'), findsOneWidget);
    await tester.ensureVisible(find.text('Earth'));
    await tester.tap(find.text('Earth'));
    await tester.pumpAndSettle();
    expect(find.text('Score: 0 / 5'), findsOneWidget);
    await tester.ensureVisible(find.text('Mars'));
    await tester.tap(find.text('Mars'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 5'), findsOneWidget);
    await tester.ensureVisible(find.text('Pacific'));
    await tester.tap(find.text('Pacific'));
    await tester.drag(
        find.byKey(const Key('quizPages')), const Offset(-600, 0));
    await tester.pumpAndSettle();
    expect(find.text('Question 3 of 5'), findsOneWidget);
    await tester.ensureVisible(find.widgetWithText(OutlinedButton, '6'));
    await tester.tap(find.widgetWithText(OutlinedButton, '6'));
    await tester.drag(find.byKey(const Key('quizPages')), const Offset(600, 0));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 5'), findsOneWidget);
    expect(find.text('Score: 3 / 5'), findsOneWidget);

    await tester.tap(find.text('BMI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 5'), findsOneWidget);
    expect(find.text('Score: 3 / 5'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, '4'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Dart'));
    await tester.tap(find.text('Dart'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(
        tester
            .widget<TextButton>(find.widgetWithText(TextButton, 'Next'))
            .onPressed,
        isNull);
    await tester.ensureVisible(find.text('Ag'));
    await tester.tap(find.text('Ag'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Finish quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Quiz complete! 4 of 5 correct (80%).'), findsOneWidget);
    expect(find.text('Correct answer: Au'), findsOneWidget);
    expect(
        tester
            .widget<OutlinedButton>(find.widgetWithText(OutlinedButton, 'Au'))
            .onPressed,
        isNull);
    await tester.tap(find.text('Restart quiz'));
    await tester.pumpAndSettle();
    expect(find.text('Score: 0 / 5'), findsOneWidget);
    expect(find.text('0 of 5 answered'), findsOneWidget);
    expect(find.text('Question 1 of 5'), findsOneWidget);
  });

  testWidgets('quiz fits a small phone and scrolls its answers',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const HelloWorldApp());
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Jupiter'));
    await tester.tap(find.text('Jupiter'));
    await tester.pumpAndSettle();
    expect(find.text('1 of 5 answered'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
