import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/changes_response.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_file_node_response.g.dart';

@PropertiesConverter()
@IdConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class ChangesFileNodeResponse extends ChangesResponse {
  final Properties? updatedProperties;

  ChangesFileNodeResponse(
    AccountId accountId,
    State oldState,
    State newState,
    bool hasMoreChanges,
    Set<Id> created,
    Set<Id> updated,
    Set<Id> destroyed, {
    this.updatedProperties,
  }) : super(
          accountId,
          oldState,
          newState,
          hasMoreChanges,
          created,
          updated,
          destroyed,
        );

  factory ChangesFileNodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangesFileNodeResponseFromJson(json);

  static ChangesFileNodeResponse deserialize(Map<String, dynamic> json) {
    final raw = _$ChangesFileNodeResponseFromJson(json);
    return ChangesFileNodeResponse(
      raw.accountId,
      raw.oldState,
      raw.newState,
      raw.hasMoreChanges,
      raw.created,
      raw.updated,
      raw.destroyed,
      updatedProperties: raw.updatedProperties,
    );
  }

  Map<String, dynamic> toJson() => _$ChangesFileNodeResponseToJson(this);

  @override
  List<Object?> get props => [
        accountId,
        oldState,
        newState,
        hasMoreChanges,
        created,
        updated,
        destroyed,
        updatedProperties,
      ];
}
