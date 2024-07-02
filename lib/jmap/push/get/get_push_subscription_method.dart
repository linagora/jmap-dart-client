import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_push_subscription_method.g.dart';

@IdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetPushSubscriptionMethod extends GetMethodNoNeedAccountId {
  GetPushSubscriptionMethod() : super();

  @override
  MethodName get methodName => MethodName('PushSubscription/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
  };

  @override
  List<Object?> get props => [methodName, ids, properties, requiredCapabilities];

  factory GetPushSubscriptionMethod.fromJson(Map<String, dynamic> json) => _$GetPushSubscriptionMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetPushSubscriptionMethodToJson(this);
}