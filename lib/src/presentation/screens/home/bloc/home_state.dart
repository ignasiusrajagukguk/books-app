part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {required this.booksListModel,
      required this.requestState,
      required this.likedBooks});

  final BooksListModel booksListModel;
  final RequestState requestState;
  final List<Result> likedBooks;

  HomeState copyWith(
      {BooksListModel? booksListModel,
      RequestState? requestState,
      List<Result>? likedBooks}) {
    return HomeState(
      booksListModel: booksListModel ?? this.booksListModel,
      requestState: requestState ?? this.requestState,
      likedBooks: likedBooks ?? this.likedBooks,
    );
  }

  factory HomeState.initial() => const HomeState(
      booksListModel: BooksListModel(),
      requestState: RequestState.empty,
      likedBooks: <Result>[]);

  @override
  List<Object> get props => [booksListModel, requestState, likedBooks];
}
