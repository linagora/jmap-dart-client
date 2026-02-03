import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class ByDay with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? day;

  ByDay({this.type, this.day});

  factory ByDay.fromJson(Map<String, dynamic> json) => _$ByDayFromJson(json);

  Map<String, dynamic> toJson() => _$ByDayToJson(this);

  @override
  List<Object?> get props => [type, day];

}

ByDay _$ByDayFromJson(Map<String, dynamic> json) => ByDay(
    type: json['@type'] as String?,
    day: json['day'] as String?,

  );

  Map<String, dynamic> _$ByDayToJson(ByDay instance) {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('@type', instance.type);
    writeNotNull('day', instance.day);
    return val;
  }
