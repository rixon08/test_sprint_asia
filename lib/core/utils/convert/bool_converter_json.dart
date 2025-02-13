import 'package:json_annotation/json_annotation.dart';

class BoolConverter implements JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is int) {
      return json == 1;
    } else if (json is bool) {
      return json;
    }
    return false;
  }

  @override
  int toJson(bool object) => object ? 1 : 0;
}