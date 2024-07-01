import 'package:bloc/bloc.dart';
import 'package:books_app/src/common/enum/request_state.dart';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/domain/usecases/local_usecases.dart';
import 'package:books_app/src/domain/usecases/remote_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBooksListUsecase getBooksListUsecase;
  final AddLikedBookUsecase addLikedBookUsecase;
  final GetLikedBookUsecase getLikedBookUsecase;
  final DeleteLikedBookUsecase deleteLikedBookUsecase;
  final AddLocalBooksUsecase addLocalBooksUsecase;
  final GetLocalBooksUsecase getLocalBooksUsecase;
  HomeBloc({
    required this.getBooksListUsecase,
    required this.addLikedBookUsecase,
    required this.getLikedBookUsecase,
    required this.deleteLikedBookUsecase,
    required this.addLocalBooksUsecase,
    required this.getLocalBooksUsecase,
  }) : super(HomeState.initial()) {
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
      BooksListModel data = await getBooksListUsecase(
          event: event, pageIndex: state.pageIndex.toString());
      _addLocalBooks(AddLocalBooks(localBooks: data.results ?? []), emit);
      emit(state.copyWith(
        booksListModel: data,
        requestState: RequestState.success,
        currentBooks: List.of(state.currentBooks)
          ..addAll(data.results as Iterable<Result>),
      ));
    } catch (e) {
      List<Result>? data = await getLocalBooksUsecase();
      if ((data ?? []).isNotEmpty) {
        emit(state.copyWith(
            currentBooks: data, requestState: RequestState.success));
      } else {
        Log.error(e);
          emit(state.copyWith(requestState: RequestState.error));
        
      }
    }
  }

  _getLikedBooks(HomeLikedBooks event, emit) async {
    try {
      List<Result>? data = await getLikedBookUsecase();
      Log.colorGreen('Liked List Length = ${(data ?? []).length}');
      emit(state.copyWith(likedBooks: data ?? []));
    } catch (e) {
      emit(state.copyWith(likedBooks: null));
      Log.error(e);
    }
  }

  _updateLikedBooks(UpdateLikedBooks event, emit) async {
    try {
      List<Result>? data = await getLikedBookUsecase();
      if (data != null && data.map((item) => item.id).contains(event.book.id)) {
        await deleteLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const HomeLikedBooks(), emit));
      } else {
        await addLikedBookUsecase(result: event.book)
            .then((value) => _getLikedBooks(const HomeLikedBooks(), emit));
      }
    } catch (e) {
      Log.error(e);
    }
  }

  _addLocalBooks(AddLocalBooks event, emit) async {
    try {
      List<Result>? data = await getLocalBooksUsecase();
      for (var i = 0; i < event.localBooks.length; i++) {
        if ((data ?? []).length < 100 &&
            !(data ?? [])
                .where(
                  (element) => element.id == event.localBooks[i].id,
                )
                .isNotEmpty) {
          Log.colorGreen("STORED");
          await addLocalBooksUsecase(result: event.localBooks[i]);
        }
      }
    } catch (e) {
      Log.error(e);
    }
  }
}
