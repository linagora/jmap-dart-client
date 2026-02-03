import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_stamp_date.g.dart';

@JsonSerializable()
class TimestampDate with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final String? type; // "Timestamp"

  final String utc; // e.g. "2019-10-15T23:10:00Z"

  const TimestampDate({
    this.type = 'Timestamp',
    required this.utc,
  });

  factory TimestampDate.fromJson(Map<String, dynamic> json) =>
      _$TimestampDateFromJson(json);

  Map<String, dynamic> toJson() => _$TimestampDateToJson(this);

  @override
  List<Object?> get props => [type, utc];
}