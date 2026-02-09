import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'name_sort_as.g.dart';

@JsonSerializable()
class NameSortAs with EquatableMixin {
  final String? surname;
  final String? given;

  NameSortAs({this.surname, this.given});

  factory NameSortAs.fromJson(Map<String, dynamic> json) =>
      _$NameSortAsFromJson(json);

  Map<String, dynamic> toJson() => _$NameSortAsToJson(this);

  @override
  List<Object?> get props => [surname, given];

  @override
  String toString() {
    return 'NameSortAs(surname: $surname, given: $given)';
  }
}
