import 'dart:convert';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/book_detail_model.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;

class BooksRepository {
  Future<BooksListModel> getBooksList(GetBooksList event) async {
    Log.colorGreen('Keyword : ${event.keywords}');
    final response = await http.get(Uri.https('gutendex.com', '/books',
        {'page': '${event.page}', 'search': event.keywords}));
    Log.colorGreen('Books List :${response.body}');
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return BooksListModel.fromJson(json);
  }

  Future<BookDetailModel> getBooksDetail({required String id}) async {
    final response = await http.get(
      Uri.parse('http://gutendex.com/books/$id'),
      headers: {},
    );
    Log.colorGreen('Books List :${response.body}');
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return BookDetailModel.fromJson(json);
  }
}
