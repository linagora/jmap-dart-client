import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_extension_fields.dart';
import 'package:json_annotation/json_annotation.dart';

class CalendarAttendeeExtensionFieldsNullableConverter implements JsonConverter<CalendarExtensionFields?, dynamic> {
  const CalendarAttendeeExtensionFieldsNullableConverter();

  @override
  CalendarExtensionFields? fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final mapExtensionFields = json.map((key, values) {
        final listFields = (values as List<dynamic>).map((value) => value as String).toList();
        return MapEntry(key, listFields);
      });
      return CalendarExtensionFields(mapExtensionFields);
    } else {
      return null;
    }
  }

  @override
  dynamic toJson(CalendarExtensionFields? object) => object?.mapFields.toString();
}