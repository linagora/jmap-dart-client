import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_thread_method.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
  converters: [
    AccountIdConverter(),
    IdConverter(),
    PropertiesConverter(),
  ],
)
class GetThreadMethod extends GetMethod {
  GetThreadMethod(super.accountId);

  @override
  MethodName get methodName => MethodName('Thread/get');

  @override
  List<Object?> get props => [accountId, ids];

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  @override
  Map<String, dynamic> toJson() => _$GetThreadMethodToJson(this);
}