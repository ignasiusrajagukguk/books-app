import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Author {
  final String? name;
  final int? birthYear;
  final int? deathYear;

  const Author({this.name, this.birthYear, this.deathYear});

  @override
  String toString() {
    return 'Author(name: $name, birthYear: $birthYear, deathYear: $deathYear)';
  }

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json['name'] as String?,
        birthYear: json['birth_year'] as int?,
        deathYear: json['death_year'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth_year': birthYear,
        'death_year': deathYear,
      };

  Author copyWith({
    String? name,
    int? birthYear,
    int? deathYear,
  }) {
    return Author(
      name: name ?? this.name,
      birthYear: birthYear ?? this.birthYear,
      deathYear: deathYear ?? this.deathYear,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Author) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ birthYear.hashCode ^ deathYear.hashCode;
}
