import 'dart:convert';

import 'package:books_app/src/common/util/logger.dart';
import 'package:books_app/src/data/models/formats.dart';
import 'package:books_app/src/data/models/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  const String localBooks = 'home_books';
  const String likedTable = 'liked_books';

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
  sqfliteTestInit();
  test('Liked Books Local Storage', () async {
    var db = await openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE $likedTable (
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

    Map<String, dynamic> bookData = {
      'id': fakeResult.id,
      'title': fakeResult.title,
      'authors': jsonEncode(fakeResult.authors),
      'subjects': jsonEncode(fakeResult.subjects),
      'bookshelves': jsonEncode(fakeResult.bookshelves),
      'translators': jsonEncode(fakeResult.translators),
      'languages': jsonEncode(fakeResult.languages),
      'copyright': fakeResult.copyright == true ? 1 : 0,
      'media_type': fakeResult.mediaType,
      'formats': jsonEncode(fakeResult.formats),
      'download_count': fakeResult.downloadCount,
    };
    Log.colorGreen(bookData);
    await db.insert(likedTable, bookData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    var result = await db.query(likedTable);
    expect(result, [
      bookData
    ]);
    await db.delete(likedTable, where: 'id = ?', whereArgs: [fakeResult.id]);
    await db.close();
  });


  test('Local Books Local Storage', () async {
    var db = await openDatabase(inMemoryDatabasePath);
        await db.execute('''
      CREATE TABLE $localBooks (
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

    Map<String, dynamic> bookData = {
      'id': fakeResult.id,
      'title': fakeResult.title,
      'authors': jsonEncode(fakeResult.authors),
      'subjects': jsonEncode(fakeResult.subjects),
      'bookshelves': jsonEncode(fakeResult.bookshelves),
      'translators': jsonEncode(fakeResult.translators),
      'languages': jsonEncode(fakeResult.languages),
      'copyright': fakeResult.copyright == true ? 1 : 0,
      'media_type': fakeResult.mediaType,
      'formats': jsonEncode(fakeResult.formats),
      'download_count': fakeResult.downloadCount,
    };
    Log.colorGreen(bookData);
    await db.insert(localBooks, bookData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    var result = await db.query(localBooks);
    expect(result, [
      bookData
    ]);
    await db.delete(localBooks, where: 'id = ?', whereArgs: [fakeResult.id]);
    await db.close();
  });
}
