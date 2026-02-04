import 'package:bloc_test/bloc_test.dart';
import 'package:rick_and_morty/domain/bloc/favorite/favorites_bloc_bloc.dart';

class MockFavorBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}
