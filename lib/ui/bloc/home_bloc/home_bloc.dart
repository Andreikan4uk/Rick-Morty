import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/data/local/db/i_db.dart';
import 'package:rick_and_morty/domain/models/card_model.dart';
import 'package:rick_and_morty/data/api/i_card_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ICardApi _repository;
  final ILocalDataSource _localDataSource;

  HomeBloc(this._repository, this._localDataSource) : super(HomeState.initial()) {
    on<_ChangePage>(_changePage);
    on<_LoadCards>(_loadCards);
    on<_Refresh>(_refresh);
    on<_LoadMoreCards>(_loadMoreCards, transformer: droppable());
  }

  Future _changePage(_ChangePage event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentIndex: event.index));
  }

  Future _refresh(_Refresh event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isRefreshing: true, error: null, hasMore: true, page: 0));

    try {
      final cards = await _repository.loadCards(page: 1);
      await _localDataSource.clearCards();
      await _localDataSource.insertCards(cards);
      emit(state.copyWith(cards: cards, isRefreshing: false, page: 1, hasMore: cards.isNotEmpty));
    } catch (e) {
      emit(state.copyWith(isRefreshing: false, error: e.toString()));
    }
  }

  Future _loadCards(_LoadCards event, Emitter<HomeState> emit) async {
    final cachedCards = await _localDataSource.getCards();
    if (cachedCards.isNotEmpty) {
      emit(state.copyWith(cards: cachedCards, isLoading: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final cards = await _repository.loadCards(page: state.page + 1);
      await _localDataSource.insertCards(cards);
      emit(state.copyWith(cards: cards, isLoading: false, page: 1, hasMore: cards.isNotEmpty));
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
        await _localDataSource.insertCards(moreCards);
        emit(state.copyWith(cards: allCards, isLoadingMore: false, page: state.page + 1, hasMore: true));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }
}
