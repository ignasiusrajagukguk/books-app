import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Translator {
  final String? name;
  final int? birthYear;
  final int? deathYear;

  const Translator({this.name, this.birthYear, this.deathYear});

  @override
  String toString() {
    return 'Author(name: $name, birthYear: $birthYear, deathYear: $deathYear)';
  }

  factory Translator.fromJson(Map<String, dynamic> json) => Translator(
        name: json['name'] as String?,
        birthYear: json['birth_year'] as int?,
        deathYear: json['death_year'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth_year': birthYear,
        'death_year': deathYear,
      };

  Translator copyWith({
    String? name,
    int? birthYear,
    int? deathYear,
  }) {
    return Translator(
      name: name ?? this.name,
      birthYear: birthYear ?? this.birthYear,
      deathYear: deathYear ?? this.deathYear,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Translator) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ birthYear.hashCode ^ deathYear.hashCode;
}
