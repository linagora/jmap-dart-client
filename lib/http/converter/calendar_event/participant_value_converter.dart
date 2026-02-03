import 'package:jmap_dart_client/http/converter/calendar_event/participant_id_converter.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar_event/participant_value.dart';

class ParticipantValueConverter {
  /// Parse a single participants entry: key is the JSCalendar Id,
  /// value must be a JSON object for ParticipantValue.
  MapEntry<ParticipantId, ParticipantValue> parseEntry(
    String key,
    dynamic value,
  ) {
    if (value is! Map<String, dynamic>) {
      throw ArgumentError(
        'Expected Map<String, dynamic> for ParticipantValue, got ${value.runtimeType}',
      );
    }
    return MapEntry(
      ParticipantId(key),
      ParticipantValue.fromJson(value),
    );
  }

  /// Serialize a ParticipantValue entry back to JSON.
  MapEntry<String, dynamic> toJson(
    ParticipantId participantId,
    ParticipantValue value,
  ) {
    return MapEntry(
      const ParticipantIdConverter().toJson(participantId),
      value.toJson(),
    );
  }
}
