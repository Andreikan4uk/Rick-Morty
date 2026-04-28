part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();

  factory HomeEvent.changePage({required int index}) = _ChangePage;

  factory HomeEvent.refresh() = _Refresh;

  factory HomeEvent.loadCards() = _LoadCards;

  factory HomeEvent.loadMoreCards() = _LoadMoreCards;

  factory HomeEvent.toggleTheme() = _ToggleTheme;
}

class _ChangePage extends HomeEvent {
  final int index;

  const _ChangePage({required this.index});
}

class _Refresh extends HomeEvent {
  const _Refresh();
}

class _LoadCards extends HomeEvent {
  const _LoadCards();
}

class _LoadMoreCards extends HomeEvent {
  const _LoadMoreCards();
}

class _ToggleTheme extends HomeEvent {
  const _ToggleTheme();
}
