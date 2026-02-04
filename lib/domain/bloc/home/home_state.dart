part of 'home_bloc.dart';

class HomeState with EquatableMixin {
  final List<CardModel> cards;
  final bool isLoading;
  final int currentIndex;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool hasMore;
  final int page;
  final String? error;
  final bool isDarkTheme;

  bool get canLoadMore => hasMore && !isLoadingMore;

  HomeState({
    required this.cards,
    this.isLoading = false,
    this.currentIndex = 0,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.page = 0,
    this.isDarkTheme = false,
    this.error,
  });

  factory HomeState.initial() => HomeState(
    currentIndex: 0,
    cards: [],
    isLoading: true,
    isRefreshing: false,
    isLoadingMore: false,
    hasMore: true,
    page: 0,
    isDarkTheme: false,
    error: null,
  );

  factory HomeState.loading({required HomeState previous}) => HomeState(
    cards: previous.cards,
    isLoading: true,
    error: null,
  );

  factory HomeState.loaded({
    required List<CardModel> cards,
    required HomeState previous,
  }) => HomeState(
    cards: cards,
    page: previous.page + 1,
    isLoading: false,
    hasMore: cards.isNotEmpty,
  );

  factory HomeState.error({
    required HomeState previous,
    required String message,
  }) => HomeState(
    cards: previous.cards,
    isLoading: false,
    isRefreshing: false,
    isLoadingMore: false,
    error: message,
  );

  factory HomeState.refreshing({
    required HomeState previous,
  }) => HomeState(
    cards: previous.cards,
    isRefreshing: true,
    hasMore: true,
    page: 0,
  );

  factory HomeState.refreshed({
    required List<CardModel> cards,
  }) => HomeState(
    cards: cards,
    isRefreshing: false,
    hasMore: cards.isNotEmpty,
    page: 1,
  );

  factory HomeState.isLoadingMore({
    required HomeState previous,
  }) => HomeState(
    cards: previous.cards,
    isLoadingMore: true,
    error: null,
  );

  factory HomeState.isLoadedMore({
    required List<CardModel> cards,
    required HomeState previous,
  }) => HomeState(
    cards: cards,
    isLoadingMore: false,
    page: previous.page + 1,
    hasMore: true,
  );

  HomeState copyWith({
    int? currentIndex,
    List<CardModel>? cards,
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    bool? hasMore,
    int? page,
    bool? isDarkTheme,
    String? error,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      cards: cards ?? this.cards,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    currentIndex,
    cards,
    isLoading,
    isRefreshing,
    isLoadingMore,
    hasMore,
    page,
    isDarkTheme,
    error,
  ];
}
