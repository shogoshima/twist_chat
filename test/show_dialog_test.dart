import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twist_chat/widgets/show_dialog.dart';

void main() {
  Future<bool> answerConfirmDialog(WidgetTester tester, String button) async {
    late Future<bool> result;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => result = showConfirmDialog(context, 'T', 'C'),
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(button));
    await tester.pumpAndSettle();
    return result;
  }

  testWidgets('confirm completes with true', (tester) async {
    expect(await answerConfirmDialog(tester, 'Confirm'), isTrue);
  });

  testWidgets('cancel completes with false', (tester) async {
    expect(await answerConfirmDialog(tester, 'Cancel'), isFalse);
  });
}
