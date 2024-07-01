import 'dart:convert';

import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/datasources/remote/books_datasource.dart';
import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/formats.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:books_app/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<BooksDataSource>(), MockSpec<http.Client>()])
import 'books_datasource_test.mocks.dart';

void main() async {
  var booksDataSource = MockBooksDataSource();
  var mockClient = MockClient();
  var booksDataSourceImplementation =
      BooksDataSourceImplementation(client: mockClient);
  String pageIndex = '1';
  String id = '1513';
  Uri booksListUrl = Uri.parse('http://gutendex.com/books/?page=2');
  Uri bookDetailUrl = Uri.parse('http://gutendex.com/books/$id');

  Result fakeResult = const Result(
      id: 1513,
      authors: [],
      bookshelves: [],
      copyright: false,
      downloadCount: 1,
      formats: Formats(),
      languages: [],
      mediaType: 'Text',
      subjects: [],
      title: 'Title',
      translators: []);
  BooksListModel fakeBooksList =
      BooksListModel(count: 123, next: '', previous: '', results: [fakeResult]);

  group('Books Data Source Abstract', () {
    test('Get Books List - Successful', () async {
      //Stubbing Process
      when(booksDataSource.getBooksList(const GetBooksList(),
              pageIndex: pageIndex))
          .thenAnswer(
        (realInvocation) async => fakeBooksList,
      );

      try {
        Log.colorGreen('API Success');
        var response = await booksDataSource.getBooksList(const GetBooksList(),
            pageIndex: pageIndex);
        Log.colorGreen(response.toJson());
      } catch (e) {
        Log.error(e);
      }
    });

    test('Get Book Detail - Successful', () async {
      //Stubbing Process
      when(booksDataSource.getBooksDetail(id: id)).thenAnswer(
        (realInvocation) async => fakeResult,
      );

      try {
        Log.colorGreen('API Success');
        var response = await booksDataSource.getBooksList(const GetBooksList(),
            pageIndex: pageIndex);
        Log.colorGreen(response.toJson());
      } catch (e) {
        Log.error(e);
      }
    });
  });

  group('Books Data Source Implementation', () {
    test('Get Book List Impl - Successful', () async {
      //Stubbing Process
      when(mockClient.get(booksListUrl)).thenAnswer(
        (realInvocation) async =>
            http.Response(jsonEncode(fakeBooksList.toJson()), 200),
      );
      try {
        Log.colorGreen('API Success');
        var response = await booksDataSourceImplementation
            .getBooksList(const GetBooksList(), pageIndex: pageIndex);
        Log.colorGreen(response.toJson());
      } catch (e) {
        Log.error(e);
      }
    });

    test('Get Book Detail Impl - Successful', () async {
      //Stubbing Process
      when(mockClient.get(bookDetailUrl)).thenAnswer(
        (realInvocation) async =>
            http.Response(jsonEncode(fakeResult.toJson()), 200),
      );
      try {
        Log.colorGreen('API Success');
        var response =
            await booksDataSourceImplementation.getBooksDetail(id: id);
        Log.colorGreen(response.toJson());
      } catch (e) {
        Log.error(e);
      }
    });
  });
}
