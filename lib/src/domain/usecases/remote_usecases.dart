import 'package:books_app/src/data/datasources/remote/books_datasource.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBooksListUsecase {
  final BooksDataSource booksDataSource;

  GetBooksListUsecase({
    required this.booksDataSource,
  });

  Future<BooksListModel> call(
      {required GetBooksList event, String? pageIndex}) async {
    return await booksDataSource.getBooksList(event, pageIndex: pageIndex);
  }
}


@lazySingleton
class GetBooksDetailUsecase {
  final BooksDataSource booksDataSource;

  GetBooksDetailUsecase({
    required this.booksDataSource,
  });

  Future<Result> call(
      {required String id, }) async {
    return await booksDataSource.getBooksDetail(id: id);
  }
}
