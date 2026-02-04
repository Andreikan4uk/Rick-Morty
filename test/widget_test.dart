// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/bloc/favorite/favorites_bloc_bloc.dart';
import 'package:rick_and_morty/domain/bloc/home/home_bloc.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:rick_and_morty/ui/screens/card_screen.dart';
import 'package:rick_and_morty/ui/widgets/character_card.dart';
import 'mocks/mock_home_bloc.dart';

void main() {
  testWidgets('CardScreen test', (WidgetTester tester) async {
    final mockHomeBloc = MockHomeBloc();
    final favorBloc = FavoritesBloc();
    // final mockFavoritesBloc = MockFavorBloc();

    final loadingState = HomeState(
      cards: const [],
      isLoading: true,
    );

    final loadedState = HomeState(
      cards: const [
        CardModel(id: 1, name: 'Rick'),
        CardModel(id: 2, name: 'Morty'),
      ],
      isLoading: false,
    );

    whenListen(
      mockHomeBloc,
      Stream<HomeState>.fromIterable([loadedState]),
      initialState: loadingState,
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>.value(value: mockHomeBloc),
          BlocProvider.value(value: favorBloc),
        ],
        child: MaterialApp(
          home: CardScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    expect(find.byType(CharacterCard), findsNWidgets(2));
    expect(find.text('Rick'), findsOneWidget);
    expect(find.text('Morty'), findsOneWidget);

    mockHomeBloc.close();
    favorBloc.close();

    // 🔹 3. нажимаем на карточку
    // await tester.tap(find.text('Rick'));
    // await tester.pumpAndSettle();

    // 🔹 4. проверяем, что открылся экран деталей
    // expect(find.text('gender'), findsOneWidget);
  });
}
