import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_converter.dart';

@RelationValueNullableConverter()
@RelationValueConverter()

class SpeakToAs with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? grammaticalGender;

  @JsonKey(includeIfNull: false)
  final String? pronouns;


  SpeakToAs({this.type, this.grammaticalGender, this.pronouns});

  factory SpeakToAs.fromJson(Map<String, dynamic> json) => _$SpeakToAsFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakToAsToJson(this);

  @override
  List<Object?> get props => [type, grammaticalGender, pronouns];

  @override
  String toString() {
    return 'SpeakToAs('
        'type: $type, '
        'grammaticalGender: $grammaticalGender, '
        'pronouns: $pronouns'
        ')';
  }
}

SpeakToAs _$SpeakToAsFromJson(Map<String, dynamic> json) => SpeakToAs(
  type : json['@type'] as String?,
  grammaticalGender : json['grammaticalGender'] as String?,
  pronouns : json['pronouns'] as String?,
);

Map<String, dynamic> _$SpeakToAsToJson(SpeakToAs instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('title', instance.grammaticalGender);
  writeNotNull('pronouns', instance.pronouns);
  return val;
}


