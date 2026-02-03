import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sort_as.g.dart';

@JsonSerializable()
class SortAs with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? surname;

  @JsonKey(includeIfNull: false)
  final String? given;


  SortAs({this.surname, this.given});

  factory SortAs.fromJson(Map<String, dynamic> json) => _$SortAsFromJson(json);

  Map<String, dynamic> toJson() => _$SortAsToJson(this);

  @override
  List<Object?> get props => [surname, given];

  @override
  String toString() {
    return 'SortAs(surname: $surname, given: $given)';
  }
}