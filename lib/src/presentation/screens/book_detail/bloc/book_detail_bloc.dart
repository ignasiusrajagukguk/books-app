import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/data/datasources/remote/books_datasource.dart';
import 'package:books_app/src/data/datasources/local/local_storage.dart';
import 'package:equatable/equatable.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc() : super(BookDetailState.initial()) {
    on<GetBookDetail>(_getBookDetail);
    on<LikedBookDetail>(_getLikedBooks);
    on<UpdateLikedBookDetail>(_updateLikedBooks);
  }

  _getBookDetail(GetBookDetail event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      Result data = await BooksDataSource.getBooksDetail(id: event.id ?? '');
      emit(state.copyWith(
          bookDetailModel: data, requestState: RequestState.success));
    } catch (e) {
      Log.error(e);
      emit(state.copyWith(requestState: RequestState.error));
    }
  }

  _getLikedBooks(LikedBookDetail event, emit) async {
    try {
      List<Result>? data = await LocalStorage.getLikedBook();
      emit(state.copyWith(likedBooks: data));
    } catch (e) {
      emit(state.copyWith(likedBooks: null));
      Log.error(e);
    }
  }

  _updateLikedBooks(UpdateLikedBookDetail event, emit) async {
    try {
      List<Result>? data = await LocalStorage.getLikedBook();
      if (data != null && data.contains(event.book)) {
        await LocalStorage.deleteLikedBook(event.book)
            .then((value) => _getLikedBooks(const LikedBookDetail(), emit));
      } else {
        await LocalStorage.addLikedBook(event.book)
            .then((value) => _getLikedBooks(const LikedBookDetail(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
