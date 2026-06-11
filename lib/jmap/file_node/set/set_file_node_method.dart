import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/set/set_method_properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/set_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/file_node/file_node.dart';

class SetFileNodeMethod extends SetMethod<FileNode> {
  SetFileNodeMethod(AccountId accountId) : super(accountId);

  bool? onDestroyRemoveChildren;

  @override
  MethodName get methodName => MethodName('FileNode/set');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapFileNode};

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('ifInState', ifInState?.value);

    writeNotNull('create', create?.map((id, fileNode) {
      return MapEntry(id.value, fileNode.toJson());
    }));

    writeNotNull('update', update?.map((id, patch) {
      return SetMethodPropertiesConverter()
          .fromMapIdToJson(id, patch.toJson());
    }));

    writeNotNull(
      'destroy',
      destroy?.map((id) => id.value).toList(),
    );

    writeNotNull('onDestroyRemoveChildren', onDestroyRemoveChildren);

    return val;
  }

  @override
  List<Object?> get props =>
      [accountId, ifInState, create, update, destroy, onDestroyRemoveChildren];
}
