part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.booksListModel,
    required this.requestState,
    required this.likedBooks,
    required this.currentBooks,
    required this.pageIndex,
  });

  final BooksListModel booksListModel;
  final RequestState requestState;
  final List<Result> likedBooks;
  final List<Result> currentBooks;
  final int pageIndex;

  HomeState copyWith({
    BooksListModel? booksListModel,
    RequestState? requestState,
    List<Result>? likedBooks,
    List<Result>? currentBooks,
    int? pageIndex,
  }) {
    return HomeState(
        booksListModel: booksListModel ?? this.booksListModel,
        requestState: requestState ?? this.requestState,
        likedBooks: likedBooks ?? this.likedBooks,
        currentBooks: currentBooks ?? this.currentBooks,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  factory HomeState.initial() => const HomeState(
      booksListModel: BooksListModel(),
      requestState: RequestState.empty,
      likedBooks: [],
      currentBooks: [],
      pageIndex: 1);

  @override
  List<Object> get props =>
      [booksListModel, requestState, likedBooks, pageIndex];
}
