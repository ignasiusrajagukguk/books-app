import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'author.dart';
import 'formats.dart';

@immutable
class Result {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<String>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;

  const Result({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  @override
  String toString() {
    return 'Result(id: $id, title: $title, authors: $authors, translators: $translators, subjects: $subjects, bookshelves: $bookshelves, languages: $languages, copyright: $copyright, mediaType: $mediaType, formats: $formats, downloadCount: $downloadCount)';
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json['id'] as int?,
        title: json['title'] as String?,
        authors: (json['authors'] as List<dynamic>?)
            ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
            .toList(),
        translators: json['translators'].cast<String>() as List<String>?,
        subjects: json['subjects'].cast<String>() as List<String>?,
        bookshelves: json['bookshelves'].cast<String>() as List<String>?,
        languages: json['languages'].cast<String>() as List<String>?,
        copyright: json['copyright'] as bool?,
        mediaType: json['media_type'] as String?,
        formats: json['formats'] == null
            ? null
            : Formats.fromJson(json['formats'] as Map<String, dynamic>),
        downloadCount: json['download_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authors?.map((e) => e.toJson()).toList(),
        'translators': translators,
        'subjects': subjects,
        'bookshelves': bookshelves,
        'languages': languages,
        'copyright': copyright,
        'media_type': mediaType,
        'formats': formats?.toJson(),
        'download_count': downloadCount,
      };

  Result copyWith({
    int? id,
    String? title,
    List<Author>? authors,
    List<String>? translators,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    Formats? formats,
    int? downloadCount,
  }) {
    return Result(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      translators: translators ?? this.translators,
      subjects: subjects ?? this.subjects,
      bookshelves: bookshelves ?? this.bookshelves,
      languages: languages ?? this.languages,
      copyright: copyright ?? this.copyright,
      mediaType: mediaType ?? this.mediaType,
      formats: formats ?? this.formats,
      downloadCount: downloadCount ?? this.downloadCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      authors.hashCode ^
      translators.hashCode ^
      subjects.hashCode ^
      bookshelves.hashCode ^
      languages.hashCode ^
      copyright.hashCode ^
      mediaType.hashCode ^
      formats.hashCode ^
      downloadCount.hashCode;
}
