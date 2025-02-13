
import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal(); // Konversi ke lokal
  }

  @override
  String toJson(DateTime object) {
    return object.toUtc().toIso8601String(); // Simpan dalam format UTC ISO 8601
  }
}