import 'package:json_annotation/json_annotation.dart';

import '../../jmap/calendar/parse.dart';

class ParsedConverter implements JsonConverter<Parsed, Map<String, dynamic>> {
  const ParsedConverter();

  @override
  Parsed fromJson(Map<String, dynamic> json) => Parsed.fromJson(json);

  @override
  Map<String, dynamic> toJson(Parsed object) => object.toJson();
}
