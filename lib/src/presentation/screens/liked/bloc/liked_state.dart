part of 'liked_bloc.dart';

class LikedState extends Equatable {
  const LikedState({required this.likedBooks, required this.requestState});

  final List<Result> likedBooks;
  final RequestState requestState;

  LikedState copyWith({
    List<Result>? likedBooks,
    RequestState? requestState,
  }) {
    return LikedState(
      likedBooks: likedBooks ?? this.likedBooks,
      requestState: requestState ?? this.requestState,
    );
  }

  factory LikedState.initial() => const LikedState(
        likedBooks: <Result>[],
        requestState: RequestState.empty,
      );

  @override
  List<Object> get props => [likedBooks, requestState];
}
