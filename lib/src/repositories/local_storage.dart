import 'dart:convert';

import 'package:books_app/src/data/models/books_list_model.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = 'books_repo.db';
  static const String _homeTable = 'home_books';
  static const String _likedTable = 'liked_books';

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _getDB();
    return _db!;
  }

  static Future<Database> _getDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    final db = await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE $_homeTable (
        data TEXT 
      )
    ''');
        await db.execute('''
      CREATE TABLE $_likedTable (
        id NUM PRIMARY KEY,
        title TEXT,
        authors TEXT,
        subjects TEXT,
        bookshelves TEXT,
        translators TEXT,
        languages TEXT,
        copyright NUM,
        media_type TEXT,
        formats TEXT,
        download_count NUM
      )
    ''');
      },
    );
    return db;
  }

  static Future<int> addHomeBook(BooksListModel booksListModel) async {
    final db = await database;
    return await db.insert(
        _homeTable, {'data': jsonEncode(booksListModel.toJson())},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addLikedBook(Result result) async {
    final db = await _getDB();
    Map<String, dynamic> bookData = {
      'id': result.id,
      'title': result.title,
      'authors': jsonEncode(result.authors),
      'subjects': jsonEncode(result.subjects),
      'bookshelves': jsonEncode(result.bookshelves),
      'translators': jsonEncode(result.translators),
      'languages': jsonEncode(result.languages),
      'copyright': result.copyright == true ? 1 : 0,
      'media_type': result.mediaType,
      'formats': jsonEncode(result.formats),
      'download_count': result.downloadCount,
    };
    return await db.insert(_likedTable, bookData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteLikedBook(Result result) async {
    final db = await database;
    return await db
        .delete(_likedTable, where: 'id = ?', whereArgs: [result.id]);
  }

  static Future<List<BooksListModel>?> getHomeBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> bookList = await db.query(_homeTable);

    if (bookList.isNotEmpty) {
      return List.generate(
          bookList.length,
          (index) =>
              BooksListModel.fromJson(jsonDecode(bookList[index]['data'])));
    } else {
      return null;
    }
  }

  static Future<List<Result>?> getLikedBook() async {
    final db = await database;
    final List<Map<String, dynamic>> bookList = await db.query(_likedTable);

    if (bookList.isNotEmpty) {
      return List.generate(
          bookList.length,
          (index) => Result.fromJson({
                'id': bookList[index]['id'],
                'title': bookList[index]['title'],
                'authors': jsonDecode(bookList[index]['authors']),
                'subjects': jsonDecode(bookList[index]['subjects']),
                'bookshelves': jsonDecode(bookList[index]['bookshelves']),
                'languages': jsonDecode(bookList[index]['languages']),
                'translators': jsonDecode(bookList[index]['translators']),
                'media_type': bookList[index]['media_type'],
                'copyright': bookList[index]['copyright'] == 1,
                'formats': jsonDecode(bookList[index]['formats']),
                'download_count': bookList[index]['download_count'],
              }));
    } else {
      return null;
    }
  }
}
