import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/domain/usecases/local_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'liked_event.dart';
part 'liked_state.dart';

@injectable
class LikedBloc extends Bloc<LikedEvent, LikedState> {
  final AddLikedBookUsecase addLikedBookUsecase;
  final GetLikedBookUsecase getLikedBookUsecase;
  final DeleteLikedBookUsecase deleteLikedBookUsecase;
  final AddLocalBooksUsecase addLocalBooksUsecase;
  final GetLocalBooksUsecase getLocalBooksUsecase;
  LikedBloc({
    required this.addLikedBookUsecase,
    required this.getLikedBookUsecase,
    required this.deleteLikedBookUsecase,
    required this.addLocalBooksUsecase,
    required this.getLocalBooksUsecase,}) : super(LikedState.initial()) {
    on<GetLikedBooks>(_getLikedBooks);
    on<UpdateLikedBooks>(_updateLikedBooks);
  }

  _getLikedBooks(GetLikedBooks event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      List<Result>? data = await getLikedBookUsecase();
      emit(state.copyWith(
          likedBooks: data,
          requestState:
              data != null ? RequestState.success : RequestState.empty));
    } catch (e) {
      Log.error(e);
      emit(state.copyWith(likedBooks: null, requestState: RequestState.error));
    }
  }

  _updateLikedBooks(UpdateLikedBooks event, emit) async {
    try {
      List<Result>? data = await getLikedBookUsecase();
      if (data != null && data.map((item) => item.id).contains(event.book.id)) {
        await deleteLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const GetLikedBooks(), emit));
      } else {
        await addLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const GetLikedBooks(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
