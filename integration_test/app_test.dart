import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_and_morty/main.dart' as app;
import 'package:rick_and_morty/ui/widgets/character_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integt teas as test_widget', (WidgetTester tester) async {
    await tester.pumpWidget(app.MyApp());
    // await tester.pumpWidget(app.MyApp(), duration: Duration(seconds: 2));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    // await tester.pump(Duration(seconds: 2));
    // await tester.pump();
    expect(find.byType(CharacterCard), findsWidgets);
    expect(find.text('Rick Sanchez'), findsOneWidget);
    expect(find.text('Morty Smith'), findsOneWidget);
  });
}
