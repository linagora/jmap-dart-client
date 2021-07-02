import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_id.g.dart';

@IdConverter()
@JsonSerializable()
class AccountId with EquatableMixin {
  final Id id;

  AccountId(this.id);

  factory AccountId.fromJson(Map<String, dynamic> json) => _$AccountIdFromJson(json);

  Map<String, dynamic> toJson() => _$AccountIdToJson(this);

  @override
  List<Object?> get props => [id];
}