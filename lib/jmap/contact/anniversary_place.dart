import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anniversary_place.g.dart';

@JsonSerializable()
class AnniversaryPlace with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? fullAddress;

  AnniversaryPlace({this.fullAddress});

  factory AnniversaryPlace.fromJson(Map<String, dynamic> json) => _$AnniversaryPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$AnniversaryPlaceToJson(this);

  @override
  List<Object?> get props => [fullAddress];

  @override
  String toString() {
    return 'AnniversaryPlace(fullAddress: $fullAddress)';
  }
}