import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/bloc/home/home_bloc.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';

import 'mocks/mock_db.dart';
import 'mocks/mock_repo.dart';

void main() {
  // late IHomeRepository repo;
  // late HomeBloc bloc;

  // setUp(() {
  //   // repo = MockRepo();
  //   // bloc = HomeBloc(repo);
  //   when(
  //     () => repo.loadCards(),
  //   ).thenReturn(Future.value([CardModel(id: 1, name: 'Rick'), CardModel(id: 2, name: 'Morty')]));
  // });
  TestWidgetsFlutterBinding.ensureInitialized();

  blocTest(
    'Checking the bloc state new',
    build: () {
      final repo = MockRepo();
      final db = MockDb();
      when(() => db.getCards()).thenAnswer((_) async => []);
      when(() => db.insertCards(any())).thenAnswer((_) async {});
      when(() => repo.loadCards(page: any(named: 'page'))).thenAnswer(
        (_) async => [
          CardModel(id: 1, name: 'Rick'),
          CardModel(id: 2, name: 'Morty'),
        ],
      );
      return HomeBloc.test(repo, db);
    },
    act: (bloc) {
      return bloc.add(HomeEvent.loadCards());
    },
    expect: () => [
      isA<HomeState>().having((e) => e.cards, 'cards', isEmpty),
      isA<HomeState>().having((e) => e.cards, 'cards', isNotEmpty),
    ],
  );
}

  // test('Checking the bloc state ', () {
  //   final state = bloc.state;

  //   expect(bloc.state, isA<HomeState>());
  // });