import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/data/datasources/remote/books_datasource.dart';
import 'package:books_app/src/data/datasources/local/local_storage.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetBooksList>(_getBookList);
    on<HomeLikedBooks>(_getLikedBooks);
    on<UpdateLikedBooks>(_updateLikedBooks);
    on<ResetPageIndex>(_resetPage);
    on<AddLocalBooks>(_addLocalBooks);
  }
  _resetPage(ResetPageIndex event, emit) {
    try {
      emit(state.copyWith(
          pageIndex: 1,
          booksListModel: const BooksListModel(),
          currentBooks: <Result>[],
          requestState: RequestState.empty));
    } catch (e) {
      Log.error(e);
    }
  }

  _getBookList(GetBooksList event, emit) async {
    try {
      if (state.booksListModel.next == null) {
        emit(state.copyWith(requestState: RequestState.loading));
      }
      BooksListModel data = await BooksDataSource.getBooksList(event,
          pageIndex: state.pageIndex.toString());
      _addLocalBooks(AddLocalBooks(localBooks: data.results ?? []), emit);
      emit(state.copyWith(
        booksListModel: data,
        requestState: RequestState.success,
        currentBooks: List.of(state.currentBooks)
          ..addAll(data.results as Iterable<Result>),
      ));
    } catch (e) {
      List<Result>? data = await LocalStorage.getLocalBooks();
      if ((data ?? []).isNotEmpty) {
        emit(state.copyWith(
            currentBooks: data, requestState: RequestState.success));
      } else {
        Log.error(e);
        if (state.booksListModel.next == null) {
          emit(state.copyWith(requestState: RequestState.error));
        }
      }
    }
  }

  _getLikedBooks(HomeLikedBooks event, emit) async {
    try {
      List<Result>? data = await LocalStorage.getLikedBook();
      emit(state.copyWith(likedBooks: data));
    } catch (e) {
      emit(state.copyWith(likedBooks: null));
      Log.error(e);
    }
  }

  _updateLikedBooks(UpdateLikedBooks event, emit) async {
    try {
      List<Result>? data = await LocalStorage.getLikedBook();
      if (data != null && data.contains(event.book)) {
        await LocalStorage.deleteLikedBook(event.book)
            .then((value) => _getLikedBooks(const HomeLikedBooks(), emit));
      } else {
        await LocalStorage.addLikedBook(event.book)
            .then((value) => _getLikedBooks(const HomeLikedBooks(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }

  _addLocalBooks(AddLocalBooks event, emit) async {
    try {
      List<Result>? data = await LocalStorage.getLocalBooks();
      for (var i = 0; i < event.localBooks.length; i++) {
        if ((data ?? []).length < 100 &&
            !(data ?? []).contains(event.localBooks[i])) {
          Log.colorGreen("STORED");
          await LocalStorage.addLocalBooks(event.localBooks[i]);
        }
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
