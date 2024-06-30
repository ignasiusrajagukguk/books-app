import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/data/datasources/local/local_storage.dart';
import 'package:equatable/equatable.dart';

part 'liked_event.dart';
part 'liked_state.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  LikedBloc() : super(LikedState.initial()) {
    on<GetLikedBooks>(_getLikedBooks);
    on<UpdateLikedBooks>(_updateLikedBooks);
  }

  _getLikedBooks(GetLikedBooks event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      List<Result>? data = await LocalStorage.getLikedBook();
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
      List<Result>? data = await LocalStorage.getLikedBook();
      if (data != null && data.contains(event.book)) {
        await LocalStorage.deleteLikedBook(event.book)
            .then((value) => _getLikedBooks(const GetLikedBooks(), emit));
      } else {
        await LocalStorage.addLikedBook(event.book)
            .then((value) => _getLikedBooks(const GetLikedBooks(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
