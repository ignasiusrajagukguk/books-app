import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/book_detail_model.dart';
import 'package:books_app/src/repositories/books_repositories.dart';
import 'package:equatable/equatable.dart';

part 'book_detail_event.dart';
part 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  BookDetailBloc() : super(BookDetailState.initial()) {
    on<GetBookDetail>(_getBookDetail);
  }

  _getBookDetail(GetBookDetail event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      BookDetailModel data =
          await BooksRepository().getBooksDetail(id: event.id ?? '');
      emit(state.copyWith(
          bookDetailModel: data, requestState: RequestState.success));
    } catch (e) {
      Log.error(e);
      emit(state.copyWith(requestState: RequestState.error));
    }
  }
}
