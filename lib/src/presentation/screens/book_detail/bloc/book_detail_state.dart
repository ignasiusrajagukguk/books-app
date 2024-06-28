part of 'book_detail_bloc.dart';

class BookDetailState extends Equatable {
  const BookDetailState(
      {required this.bookDetailModel, required this.requestState});

  final BookDetailModel bookDetailModel;
  final RequestState requestState;

  BookDetailState copyWith({
    BookDetailModel? bookDetailModel,
    RequestState? requestState,
  }) {
    return BookDetailState(
      bookDetailModel: bookDetailModel ?? this.bookDetailModel,
      requestState: requestState ?? this.requestState,
    );
  }

  factory BookDetailState.initial() => const BookDetailState(
        bookDetailModel: BookDetailModel(),
        requestState: RequestState.empty,
      );

  @override
  List<Object> get props => [bookDetailModel, requestState];
}
