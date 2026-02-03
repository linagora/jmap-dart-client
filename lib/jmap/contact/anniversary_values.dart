import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'anniversary_place.dart';

part 'anniversary_values.g.dart';

@JsonSerializable()

class AnniversaryValue with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? anniversaryType;

  @JsonKey(includeIfNull: false)
  final String? kind;

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? date;

  final AnniversaryPlace? place;

  @JsonKey(includeIfNull: false)
  final String? label;

  AnniversaryValue({this.anniversaryType, this.type, this.kind, this.place, this.date, this.label});

  factory AnniversaryValue.fromJson(Map<String, dynamic> json) => _$AnniversaryValueFromJson(json);

  Map<String, dynamic> toJson() => _$AnniversaryValueToJson(this);

  @override
  List<Object?> get props => [anniversaryType, type, kind, place, date, label];

  @override
  String toString() {
    return 'AnniversaryValue('
        'anniversaryType: $anniversaryType, '
        'type: $type, '
        'kind: $kind, '
        'place: $place, '
        'date: $date, '
        'label: $label'
        ')';
  }
}
