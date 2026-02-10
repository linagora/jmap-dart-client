import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_to.g.dart';

@JsonSerializable()
class SendTo with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final String? imip;

  @JsonKey(includeIfNull: false)
  final String? other;

  SendTo({this.imip, this.other});

  factory SendTo.fromJson(Map<String, dynamic> json) =>
      _$SendToFromJson(json);

  Map<String, dynamic> toJson() => _$SendToToJson(this);

  @override
  List<Object?> get props => [imip, other];

  @override
  String toString() {
    return 'SendTo('
        'imip: $imip, '
        'other: $other'
        ')';
  }
}
