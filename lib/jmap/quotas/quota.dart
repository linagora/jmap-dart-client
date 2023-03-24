
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/quotas/data_type_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/quotas/data_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quota.g.dart';

@DataTypeConverter()
@IdConverter()
@UnsignedIntNullableConverter()
@JsonSerializable(explicitToJson: true)
class Quota with EquatableMixin {
  final Id id;
  final ResourceType resourceType;
  final UnsignedInt? used;
  final UnsignedInt? limit;
  final Scope scope;
  final String name;
  final List<DataType> dataTypes;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? warnLimit;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? softLimit;

  @JsonKey(includeIfNull: false)
  final String? description;

  Quota(
    this.id,
    this.resourceType,
    this.used,
    this.limit,
    this.scope,
    this.name,
    this.dataTypes,
    {
      this.warnLimit,
      this.softLimit,
      this.description
    }
  );

  factory Quota.fromJson(Map<String, dynamic> json) => _$QuotaFromJson(json);

  Map<String, dynamic> toJson() => _$QuotaToJson(this);

  @override
  List<Object?> get props => [
    id,
    resourceType,
    used,
    limit,
    scope,
    name,
    dataTypes,
    warnLimit,
    softLimit,
    description
  ];
}