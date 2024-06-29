part of 'liked_bloc.dart';

abstract class LikedEvent extends Equatable {
  const LikedEvent();

  @override
  List<Object> get props => [];
}

class GetLikedBooks extends LikedEvent {
  const GetLikedBooks();
}

class UpdateLikedBooks extends LikedEvent {
  final Result book;
  const UpdateLikedBooks({required this.book});
}
