import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_type_converter.dart';

part 'related_to_values.g.dart';

@RelationValueNullableConverter()
@RelationValueConverter()
@RelationTypeConverter()
class RelatedToValue with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final Map<Relation, bool>? relation;

  RelatedToValue({
    this.type = 'Relation',
    this.relation,
  });

  factory RelatedToValue.fromJson(Map<String, dynamic> json) =>
      _$RelatedToValueFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedToValueToJson(this);

  @override
  List<Object?> get props => [type, relation];

  @override
  String toString() =>
      'RelatedToValue(type: $type, relation: $relation)';
}
