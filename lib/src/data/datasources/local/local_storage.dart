import 'dart:convert';
import 'package:books_app/src/data/models/result.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalStorage {
  Future<int> addLikedBook(Result result);
  Future<List<Result>?> getLikedBook();
  Future<int> deleteLikedBook(Result result);
  Future<int> addLocalBooks(Result result);
  Future<List<Result>?> getLocalBooks();
}

@LazySingleton(as: LocalStorage)
class LocalStorageImplementationc extends LocalStorage {
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = 'books_repo.db';
  static const String _localBooks = 'home_books';
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
      CREATE TABLE $_localBooks (
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

  @override
  Future<int> addLikedBook(Result result) async {
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

  @override
  Future<List<Result>?> getLikedBook() async {
    final db = await database;
    final List<Map<String, dynamic>> bookList = await db.query(_likedTable);

    if (bookList.isNotEmpty) {
      return List.generate(
          bookList.length,
          (index) => Result.fromJson({
                'id': bookList[index]['id'] as int?,
                'title': bookList[index]['title'],
                'authors': jsonDecode(bookList[index]['authors']),
                'subjects': jsonDecode(bookList[index]['subjects']),
                'bookshelves': jsonDecode(bookList[index]['bookshelves']),
                'languages': jsonDecode(bookList[index]['languages']),
                'translators': jsonDecode(bookList[index]['translators']),
                'media_type': bookList[index]['media_type'],
                'copyright': bookList[index]['copyright'] == 1,
                'formats': jsonDecode(bookList[index]['formats']),
                'download_count': bookList[index]['download_count'] as int?,
              }));
    } else {
      return null;
    }
  }

  @override
  Future<int> deleteLikedBook(Result result) async {
    final db = await database;
    return await db
        .delete(_likedTable, where: 'id = ?', whereArgs: [result.id]);
  }

  @override
  Future<int> addLocalBooks(Result result) async {
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
    return await db.insert(_localBooks, bookData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Result>?> getLocalBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> bookList = await db.query(_localBooks);

    if (bookList.isNotEmpty) {
      return List.generate(
          bookList.length,
          (index) => Result.fromJson({
                'id': bookList[index]['id'] as int?,
                'title': bookList[index]['title'],
                'authors': jsonDecode(bookList[index]['authors']),
                'subjects': jsonDecode(bookList[index]['subjects']),
                'bookshelves': jsonDecode(bookList[index]['bookshelves']),
                'translators': jsonDecode(bookList[index]['translators']),
                'languages': jsonDecode(bookList[index]['languages']),
                'copyright': bookList[index]['copyright'] == 1,
                'media_type': bookList[index]['media_type'],
                'formats': jsonDecode(bookList[index]['formats']),
                'download_count': bookList[index]['download_count']as int?,
              }));
    } else {
      return null;
    }
  }
}
