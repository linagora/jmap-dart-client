import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participants.g.dart';

@JsonSerializable()
class Participants with EquatableMixin {
  final String? name;
  final String? mailto;
  final String? kind;
  final String? role;
  final String? participationStatus;
  final bool? expectReply;

  Participants(
      {this.name,
      this.mailto,
      this.kind,
      this.role,
      this.participationStatus,
      this.expectReply});

  factory Participants.fromJson(Map<String, dynamic> json) =>
      _$ParticipantsFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantsToJson(this);

  @override
  List<Object?> get props =>
      [name, mailto, kind, role, participationStatus, expectReply];
}
