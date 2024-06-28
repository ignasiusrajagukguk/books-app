import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/repositories/books_repositories.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetBooksList>(_getBookList);
  }

  _getBookList(GetBooksList event, emit) async {
    try {
      emit(state.copyWith(requestState: RequestState.loading));
      BooksListModel data = await BooksRepository().getBooksList(event);
      emit(state.copyWith(
          booksListModel: data, requestState: RequestState.success));
    } catch (e) {
      Log.error(e);
      emit(state.copyWith(requestState: RequestState.error));
    }
  }
}
