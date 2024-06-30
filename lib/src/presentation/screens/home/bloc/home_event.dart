part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetBooksList extends HomeEvent {
  final String? keywords;
  const GetBooksList({this.keywords});
}

class HomeLikedBooks extends HomeEvent {
  const HomeLikedBooks();
}

class UpdateLikedBooks extends HomeEvent {
  final Result book;
  const UpdateLikedBooks({required this.book});
}

class ResetPageIndex extends HomeEvent {
  const ResetPageIndex();
}

class AddLocalBooks extends HomeEvent {
  final List<Result> localBooks;
  const AddLocalBooks({required this.localBooks});
}
