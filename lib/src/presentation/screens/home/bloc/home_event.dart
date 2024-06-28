part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetBooksList extends HomeEvent {
  final int? page;
  final String? keywords;
  const GetBooksList({this.page, this.keywords});
}
