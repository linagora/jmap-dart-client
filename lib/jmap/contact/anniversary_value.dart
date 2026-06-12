import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/time_stamp_date.dart';
import 'anniversary_place.dart';
import 'partial_date.dart';

/// Anniversary value supporting JSContact/IETF and Cyrus formats.
///
/// - JSContact/IETF: `date` is a `PartialDate` or `TimestampDate` object
/// - Cyrus: `date` is a plain `String` (e.g. "2023-05-10")
class AnniversaryValue with EquatableMixin {
  final String? type;

  final String? kind;

  /// JSContact/IETF: PartialDate or TimestampDate
  /// Cyrus: plain String like "12-04-2023"
  final Object? date;

  final String? anniversaryType;

  final AnniversaryPlace? place;

  const AnniversaryValue({
    this.type = 'Anniversary',
    this.kind,
    this.date,
    this.anniversaryType,
    this.place,
  });

  /// - If it's a map and `@type == "Timestamp"` or has `utc`, use TimestampDate.
  /// - If it's a map otherwise, use PartialDate.
  /// - Else, keep the raw value (e.g. Cyrus string).
  factory AnniversaryValue.fromJson(Map<String, dynamic> json) {
    final rawDate = json['date'];
    Object? parsedDate;

    if (rawDate is Map<String, dynamic>) {
      final t = rawDate['@type'] as String?;
      if (t == 'Timestamp' || rawDate.containsKey('utc')) {
        parsedDate = TimestampDate.fromJson(rawDate);
      } else {
        parsedDate = PartialDate.fromJson(rawDate);
      }
    } else {
      parsedDate = rawDate;
    }

    return AnniversaryValue(
      type: json['@type'] as String? ?? json['type'] as String?,
      kind: json['kind'] as String?,
      date: parsedDate,
      anniversaryType: json['anniversaryType'] as String?,
      place: json['place'] != null
          ? AnniversaryPlace.fromJson(json['place'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (type != null) map['@type'] = type;
    if (kind != null) map['kind'] = kind;
    if (anniversaryType != null) map['anniversaryType'] = anniversaryType;

    if (date != null) {
      if (date is PartialDate) {
        map['date'] = (date as PartialDate).toJson();
      } else if (date is TimestampDate) {
        map['date'] = (date as TimestampDate).toJson();
      } else {
        map['date'] = date;
      }
    }

    if (place != null) map['place'] = place!.toJson();

    return map;
  }

  @override
  List<Object?> get props => [type, kind, date, anniversaryType, place];

  @override
  String toString() {
    final parts = <String>[];

    if (type != null) parts.add('type: $type');
    if (kind != null) parts.add('kind: $kind');
    if (date != null) parts.add('date: $date');
    if (anniversaryType != null) parts.add('anniversaryType: $anniversaryType');
    if (place != null) parts.add('place: $place');

    return 'AnniversaryValue(${parts.join(', ')})';
  }
}
