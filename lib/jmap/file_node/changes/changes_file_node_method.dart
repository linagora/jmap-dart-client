import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/changes_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_file_node_method.g.dart';

@UnsignedIntNullableConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class ChangesFileNodeMethod extends ChangesMethod {
  ChangesFileNodeMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
  }) : super(accountId, sinceState, maxChanges: maxChanges);

  @override
  MethodName get methodName => MethodName('FileNode/changes');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapFileNode};

  @override
  List<Object?> get props =>
      [accountId, sinceState, maxChanges];

  factory ChangesFileNodeMethod.fromJson(Map<String, dynamic> json) =>
      _$ChangesFileNodeMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangesFileNodeMethodToJson(this);
}
