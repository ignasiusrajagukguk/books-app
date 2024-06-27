part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.booksListModel, required this.requestState});

  final BooksListModel booksListModel;
  final RequestState requestState;

  HomeState copyWith({
    BooksListModel? booksListModel,
    RequestState? requestState,
  }) {
    return HomeState(
      booksListModel: booksListModel ?? this.booksListModel,
      requestState: requestState ?? this.requestState,
    );
  }

  factory HomeState.initial() => const HomeState(
        booksListModel: BooksListModel(),
        requestState: RequestState.empty,
      );

  @override
  List<Object> get props => [booksListModel, requestState];
}
