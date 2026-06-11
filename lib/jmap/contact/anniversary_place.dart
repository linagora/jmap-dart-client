import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anniversary_place.g.dart';

@JsonSerializable()
class AnniversaryPlace with EquatableMixin {

  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? fullAddress;

  AnniversaryPlace({this.type = 'Address', this.fullAddress});

  factory AnniversaryPlace.fromJson(Map<String, dynamic> json) => _$AnniversaryPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$AnniversaryPlaceToJson(this);

  @override
  List<Object?> get props => [type, fullAddress];

  @override
  String toString() {
    return 'AnniversaryPlace(type: $type, fullAddress: $fullAddress)';
  }
}