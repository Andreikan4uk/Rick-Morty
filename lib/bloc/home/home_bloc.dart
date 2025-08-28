import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/domain/db/db.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:rick_and_morty/domain/repository/i_home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHomeRepository _repository;

  HomeBloc(this._repository) : super(HomeState.initial()) {
    on<_ChangePage>(_changePage);
    on<_LoadCards>(_loadCards);
    on<_Refresh>(_refresh);
    on<_LoadMoreCards>(_loadMoreCards, transformer: droppable());
    on<_ToggleTheme>(_toggleTheme);
    add(_LoadCards());
  }

  Future _changePage(_ChangePage event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentIndex: event.index));
  }

  Future _refresh(_Refresh event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRefreshing: true, error: null, hasMore: true, page: 0));

    try {
      final cards = await _repository.loadCards(page: state.page + 1);
      emit(state.copyWith(cards: cards, isRefreshing: false, page: 1, hasMore: cards.isNotEmpty));
      await DBProvider.db.insertCards(cards);
    } catch (e) {
      emit(state.copyWith(isRefreshing: false, error: e.toString()));
    }
  }

  Future _loadCards(_LoadCards event, Emitter<HomeState> emit) async {
    final cachedCards = await DBProvider.db.getCards();
    if (cachedCards.isNotEmpty) {
      emit(state.copyWith(cards: cachedCards));
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final cards = await _repository.loadCards(page: state.page + 1);
      emit(state.copyWith(cards: cards, isLoading: false, page: 1, hasMore: cards.isNotEmpty));
      await DBProvider.db.insertCards(cards);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future _loadMoreCards(_LoadMoreCards event, Emitter<HomeState> emit) async {
    if (!state.canLoadMore) return;

    emit(state.copyWith(isLoadingMore: true, error: null));

    try {
      final moreCards = await _repository.loadCards(page: state.page + 1);

      if (moreCards.isEmpty) {
        emit(state.copyWith(isLoadingMore: false, hasMore: false));
      } else {
        final allCards = [...state.cards, ...moreCards];
        await DBProvider.db.insertCards(allCards);
        emit(state.copyWith(cards: allCards, isLoadingMore: false, page: state.page + 1, hasMore: true));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }

  Future _toggleTheme(_ToggleTheme event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isDarkTheme: !state.isDarkTheme));
  }
}
