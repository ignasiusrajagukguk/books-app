import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'result.dart';

@immutable
class BooksListModel {
  final int? count;
  final String? next;
  final dynamic previous;
  final List<Result>? results;

  const BooksListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  @override
  String toString() {
    return 'BooksListModel(count: $count, next: $next, previous: $previous, results: $results)';
  }

  factory BooksListModel.fromJson(Map<String, dynamic> json) {
    return BooksListModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as dynamic,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results?.map((e) => e.toJson()).toList(),
      };

  BooksListModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<Result>? results,
  }) {
    return BooksListModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BooksListModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other, toJson());
  }

  @override
  int get hashCode =>
      count.hashCode ^ next.hashCode ^ previous.hashCode ^ results.hashCode;
}
