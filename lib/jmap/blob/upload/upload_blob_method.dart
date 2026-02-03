import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/jmap/blob/blob.dart';
import 'package:jmap_dart_client/jmap/core/method/request/set_method.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

class UploadBlobMethod extends SetMethod<Blob> {
  UploadBlobMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Blob/upload');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapBlob};

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    if (create != null && create!.isNotEmpty) {
      json['create'] = create!.map(
        (id, blob) => MapEntry(id.value, blob.toJson()),
      );
    }

    return json;
  }

  @override
  List<Object?> get props => [accountId, create];
}
