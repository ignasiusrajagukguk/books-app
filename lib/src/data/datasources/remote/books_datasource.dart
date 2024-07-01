import 'dart:convert';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

abstract class BooksDataSource {
  Future<BooksListModel> getBooksList(GetBooksList event, {String? pageIndex});
  Future<Result> getBooksDetail({required String id});
}

@LazySingleton(as: BooksDataSource)
class BooksDataSourceImplementation extends BooksDataSource {
  final http.Client client;
  BooksDataSourceImplementation({required this.client});

  @override
  Future<BooksListModel> getBooksList(GetBooksList event,
      {String? pageIndex}) async {
    Log.colorGreen('Keyword : ${event.keywords}');
    final response = await client.get(Uri.https('gutendex.com', '/books',
        {'page': '$pageIndex', 'search': event.keywords}));
    Log.colorGreen('Books List :${response.body}');
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return BooksListModel.fromJson(json);
  }

  @override
  Future<Result> getBooksDetail({required String id}) async {
    final response = await client.get(
      Uri.parse('http://gutendex.com/books/$id'),
      headers: {},
    );
    Log.colorGreen('Books List :${response.body}');
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Result.fromJson(json);
  }
}
