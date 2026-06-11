import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'partial_date.g.dart';

@JsonSerializable()
class PartialDate with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final int? year;

  @JsonKey(includeIfNull: false)
  final int? month;

  @JsonKey(includeIfNull: false)
  final int? day;

  const PartialDate({
    this.type = 'PartialDate',
    this.year,
    this.month,
    this.day,
  });

  factory PartialDate.fromJson(Map<String, dynamic> json) =>
      _$PartialDateFromJson(json);

  Map<String, dynamic> toJson() => _$PartialDateToJson(this);

  @override
  List<Object?> get props => [type, year, month, day];
}
