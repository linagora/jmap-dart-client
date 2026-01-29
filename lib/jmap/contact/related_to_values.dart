import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_type_converter.dart';


@RelationValueNullableConverter()
@RelationValueConverter()

class RelatedToValue with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? type;

  final Map<Relation, bool>? relation;

  RelatedToValue({this.type, this.relation});

  factory RelatedToValue.fromJson(Map<String, dynamic> json) => _$RelatedToValueFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedToValueToJson(this);

  @override
  List<Object?> get props => [type, relation];

  @override
  String toString() {
    return 'RelatedToValue('
        'type: $type, '
        'relation: $relation'
        ')';
  }
}

RelatedToValue _$RelatedToValueFromJson(Map<String, dynamic> json) => RelatedToValue(
  type : json['@type'] as String?,
  relation: (json['relation'] as Map<String, dynamic>?)?.map((key, value) =>  RelationConverter().parseEntry(key, value)),
);

Map<String, dynamic> _$RelatedToValueToJson(RelatedToValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('relation', instance.relation?.map((key, value) =>   RelationConverter().toJson(key, value)));
  return val;
}


