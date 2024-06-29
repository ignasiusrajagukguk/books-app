part of 'book_detail_bloc.dart';

class BookDetailState extends Equatable {
  const BookDetailState(
      {required this.bookDetailModel,
      required this.requestState,
      required this.likedBooks});

  final BookDetailModel bookDetailModel;
  final RequestState requestState;
  final List<Result> likedBooks;

  BookDetailState copyWith(
      {BookDetailModel? bookDetailModel,
      RequestState? requestState,
      List<Result>? likedBooks}) {
    return BookDetailState(
        bookDetailModel: bookDetailModel ?? this.bookDetailModel,
        requestState: requestState ?? this.requestState,
        likedBooks: likedBooks ?? this.likedBooks);
  }

  factory BookDetailState.initial() => const BookDetailState(
      bookDetailModel: BookDetailModel(),
      requestState: RequestState.empty,
      likedBooks: <Result>[]);

  @override
  List<Object> get props => [bookDetailModel, requestState, likedBooks];
}
