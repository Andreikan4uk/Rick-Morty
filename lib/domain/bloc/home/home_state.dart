part of 'home_bloc.dart';

class HomeState with EquatableMixin {
  final int currentIndex;
  final List<CardModel> cards;
  final bool isLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool hasMore;
  final int page;
  final String? error;
  final bool isDarkTheme;

  bool get canLoadMore => hasMore && !isLoadingMore;

  HomeState({
    required this.currentIndex,
    required this.cards,
    required this.isLoading,
    required this.isRefreshing,
    required this.isLoadingMore,
    required this.hasMore,
    required this.page,
    required this.isDarkTheme,
    this.error,
  });

  factory HomeState.initial() => HomeState(
    currentIndex: 0,
    cards: [],
    isLoading: false,
    isRefreshing: false,
    isLoadingMore: false,
    hasMore: true,
    page: 0,
    isDarkTheme: false,
    error: null,
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
