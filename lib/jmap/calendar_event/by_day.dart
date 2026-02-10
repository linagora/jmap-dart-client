import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'by_day.g.dart';

@JsonSerializable()
class ByDay with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? day;

  ByDay({this.type, this.day});

  factory ByDay.fromJson(Map<String, dynamic> json) =>
      _$ByDayFromJson(json);

  Map<String, dynamic> toJson() => _$ByDayToJson(this);

  @override
  List<Object?> get props => [type, day];
}
