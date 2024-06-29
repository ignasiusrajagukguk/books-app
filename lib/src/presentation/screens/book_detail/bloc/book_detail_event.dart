part of 'book_detail_bloc.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object> get props => [];
}

class GetBookDetail extends BookDetailEvent {
  final String? id;
  const GetBookDetail({this.id});
}

class LikedBookDetail extends BookDetailEvent {
  const LikedBookDetail();
}

class UpdateLikedBookDetail extends BookDetailEvent {
  final Result book;
  const UpdateLikedBookDetail({required this.book});
}
