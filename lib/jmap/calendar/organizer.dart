import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organizer.g.dart';

@JsonSerializable()
class Organizer with EquatableMixin {
  final String? name;
  final String? mailto;

  Organizer({this.name, this.mailto});

  factory Organizer.fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerToJson(this);

  @override
  List<Object?> get props => [name, mailto];
}
