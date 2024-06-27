import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Formats {
  final String? textHtml;
  final String? applicationEpubZip;
  final String? applicationXMobipocketEbook;
  final String? applicationRdfXml;
  final String? imageJpeg;
  final String? textPlainCharsetUsAscii;
  final String? applicationOctetStream;

  const Formats({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.applicationRdfXml,
    this.imageJpeg,
    this.textPlainCharsetUsAscii,
    this.applicationOctetStream,
  });

  @override
  String toString() {
    return 'Formats(textHtml: $textHtml, applicationEpubZip: $applicationEpubZip, applicationXMobipocketEbook: $applicationXMobipocketEbook, applicationRdfXml: $applicationRdfXml, imageJpeg: $imageJpeg, textPlainCharsetUsAscii: $textPlainCharsetUsAscii, applicationOctetStream: $applicationOctetStream)';
  }

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json['text/html'] as String?,
        applicationEpubZip: json['application/epub+zip'] as String?,
        applicationXMobipocketEbook:
            json['application/x-mobipocket-ebook'] as String?,
        applicationRdfXml: json['application/rdf+xml'] as String?,
        imageJpeg: json['image/jpeg'] as String?,
        textPlainCharsetUsAscii:
            json['text/plain; charset=us-ascii'] as String?,
        applicationOctetStream: json['application/octet-stream'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'text/html': textHtml,
        'application/epub+zip': applicationEpubZip,
        'application/x-mobipocket-ebook': applicationXMobipocketEbook,
        'application/rdf+xml': applicationRdfXml,
        'image/jpeg': imageJpeg,
        'text/plain; charset=us-ascii': textPlainCharsetUsAscii,
        'application/octet-stream': applicationOctetStream,
      };

  Formats copyWith({
    String? textHtml,
    String? applicationEpubZip,
    String? applicationXMobipocketEbook,
    String? applicationRdfXml,
    String? imageJpeg,
    String? textPlainCharsetUsAscii,
    String? applicationOctetStream,
  }) {
    return Formats(
      textHtml: textHtml ?? this.textHtml,
      applicationEpubZip: applicationEpubZip ?? this.applicationEpubZip,
      applicationXMobipocketEbook:
          applicationXMobipocketEbook ?? this.applicationXMobipocketEbook,
      applicationRdfXml: applicationRdfXml ?? this.applicationRdfXml,
      imageJpeg: imageJpeg ?? this.imageJpeg,
      textPlainCharsetUsAscii:
          textPlainCharsetUsAscii ?? this.textPlainCharsetUsAscii,
      applicationOctetStream:
          applicationOctetStream ?? this.applicationOctetStream,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Formats) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      textHtml.hashCode ^
      applicationEpubZip.hashCode ^
      applicationXMobipocketEbook.hashCode ^
      applicationRdfXml.hashCode ^
      imageJpeg.hashCode ^
      textPlainCharsetUsAscii.hashCode ^
      applicationOctetStream.hashCode;
}
