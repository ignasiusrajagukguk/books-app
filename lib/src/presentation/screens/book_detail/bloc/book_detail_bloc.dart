import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/domain/usecases/local_usecases.dart';
import 'package:books_app/src/domain/usecases/remote_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

@injectable
class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBooksDetailUsecase getBooksDetailUsecase;
  final GetBooksListUsecase getBooksListUsecase;
  final AddLikedBookUsecase addLikedBookUsecase;
  final GetLikedBookUsecase getLikedBookUsecase;
  final DeleteLikedBookUsecase deleteLikedBookUsecase;
  final AddLocalBooksUsecase addLocalBooksUsecase;
  final GetLocalBooksUsecase getLocalBooksUsecase;
  BookDetailBloc({
    required this.getBooksDetailUsecase,
    required this.getBooksListUsecase,
    required this.addLikedBookUsecase,
    required this.getLikedBookUsecase,
    required this.deleteLikedBookUsecase,
    required this.addLocalBooksUsecase,
    required this.getLocalBooksUsecase,
  }) : super(BookDetailState.initial()) {
    on<GetBookDetail>(_getBookDetail);
    on<LikedBookDetail>(_getLikedBooks);
    on<UpdateLikedBookDetail>(_updateLikedBooks);
  }

  _getBookDetail(GetBookDetail event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      Result data = await getBooksDetailUsecase(id: event.id ?? '');
      emit(state.copyWith(
          bookDetailModel: data, requestState: RequestState.success));
    } catch (e) {
      Log.error(e);
      emit(state.copyWith(requestState: RequestState.error));
    }
  }

  _getLikedBooks(LikedBookDetail event, emit) async {
    try {
      List<Result>? data = await getLikedBookUsecase();
      emit(state.copyWith(likedBooks: data??[]));
    } catch (e) {
      emit(state.copyWith(likedBooks: null));
      Log.error(e);
    }
  }

  _updateLikedBooks(UpdateLikedBookDetail event, emit) async {
    try {
      List<Result>? data = await getLikedBookUsecase();
      if (data != null &&
        data.map((item) => item.id).contains(event.book.id)) {
        await deleteLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const LikedBookDetail(), emit));
      } else {
        await addLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const LikedBookDetail(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
