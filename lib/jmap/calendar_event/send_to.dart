import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class SendTo with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? imip;

  @JsonKey(includeIfNull: false)
  final String? other;

  SendTo({this.imip, this.other});

  factory SendTo.fromJson(Map<String, dynamic> json) => _$SendToFromJson(json);

  Map<String, dynamic> toJson() => _$SendToJson(this);

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

SendTo _$SendToFromJson(Map<String, dynamic> json) => SendTo(
  imip: json['imip'] as String?,
  other: json['other'] as String?,
);

Map<String, dynamic> _$SendToJson(SendTo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imip', instance.imip);
  writeNotNull('other', instance.other);
  return val;
}
