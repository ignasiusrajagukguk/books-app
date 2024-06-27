import 'dart:convert';
import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/books_list_model/books_list_model.dart';
import 'package:http/http.dart' as http;

class BooksRepository {
  Future<BooksListModel> getBooksList({int? page, String? keywords}) async {
    Log.colorGreen('Keyword : $keywords');
    final response = await http.get(
      Uri.https('gutendex.com','/books',{'page':'$page', 'search':keywords})

    );
    Log.colorGreen('Books List :${response.body}');
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return BooksListModel.fromJson(json);
  }
}
