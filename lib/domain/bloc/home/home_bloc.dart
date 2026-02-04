import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/db/i_db.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:rick_and_morty/domain/repository/i_home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repository;
  final ILocalDataSource _localDataSource;

  HomeBloc(this._repository, this._localDataSource) : super(HomeState.initial()) {
    // для тестов реализация с bool loadOnStart = true в конструкторе и if(loadOnStart){add(_LoadCards());} в конце
    on<_ChangePage>(_changePage);
    on<_LoadCards>(_loadCards);
    on<_Refresh>(_refresh);
    on<_LoadMoreCards>(_loadMoreCards, transformer: droppable());
    on<_ToggleTheme>(_toggleTheme);
    add(_LoadCards());
  }

  HomeBloc.test(this._repository, this._localDataSource) : super(HomeState.initial()) {
    on<_LoadCards>(_loadCards);
  }

  Future _changePage(_ChangePage event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentIndex: event.index));
  }

  Future _refresh(_Refresh event, Emitter<HomeState> emit) async {
    emit(HomeState.refreshing(previous: state));
    // emit(state.copyWith(isRefreshing: true, error: null, hasMore: true, page: 0));
    try {
      const firstPage = 1;
      final cards = await _repository.loadCards(page: firstPage);
      await _localDataSource.insertCards(cards);
      emit(HomeState.refreshed(cards: cards));
      // emit(state.copyWith(cards: cards, isRefreshing: false, page: firstPage, hasMore: cards.isNotEmpty));
    } catch (e) {
      emit(HomeState.error(previous: state, message: e.toString()));
      // emit(state.copyWith(isRefreshing: false, error: e.toString()));
    }
  }

  Future _loadCards(_LoadCards event, Emitter<HomeState> emit) async {
    emit(HomeState.loading(previous: state));
    final cachedCards = await _localDataSource.getCards();
    if (cachedCards.isNotEmpty) {
      emit(
        state.copyWith(cards: cachedCards, isLoading: false),
      );
    }
    // emit(state.copyWith(isLoading: true, error: null));
    try {
      final nextPage = state.page + 1;
      final cards = await _repository.loadCards(page: nextPage);
      await _localDataSource.insertCards(cards);
      emit(HomeState.loaded(cards: cards, previous: state));
      // emit(state.copyWith(cards: cards, isLoading: false, page: nextPage, hasMore: cards.isNotEmpty));
    } catch (e) {
      emit(HomeState.error(previous: state, message: e.toString()));
      // emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future _loadMoreCards(_LoadMoreCards event, Emitter<HomeState> emit) async {
    if (!state.canLoadMore) return;

    emit(HomeState.isLoadingMore(previous: state));
    // emit(state.copyWith(isLoadingMore: true, error: null));

    try {
      final moreCards = await _repository.loadCards(page: state.page + 1);

      if (moreCards.isEmpty) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      } else {
        final allCards = [...state.cards, ...moreCards];
        await _localDataSource.insertCards(allCards);
        emit(HomeState.isLoadedMore(cards: allCards, previous: state));
        // emit(state.copyWith(cards: allCards, isLoadingMore: false, page: state.page + 1, hasMore: true));
      }
    } catch (e) {
      emit(HomeState.error(previous: state, message: e.toString()));
      // emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }

  Future _toggleTheme(_ToggleTheme event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isDarkTheme: state.isDarkTheme));
  }
}
