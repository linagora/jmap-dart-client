import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_contact_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetContactMethod extends GetMethod {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ContactApiVersion apiVersion;

  GetContactMethod(
    AccountId accountId, {
    this.apiVersion = ContactApiVersion.jscontact,
  }) : super(accountId);

  @override
  MethodName get methodName {
    switch (apiVersion) {
      case ContactApiVersion.cyrus:
        return MethodName('Contact/get');
      case ContactApiVersion.ietf:
        return MethodName('ContactCard/get');
      case ContactApiVersion.jscontact:
        return MethodName('Card/get');
    }
  }

  @override
  Set<CapabilityIdentifier> get requiredCapabilities {
    switch (apiVersion) {
      case ContactApiVersion.cyrus:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapCyrusContact,
        };
      case ContactApiVersion.ietf:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapContactCard,
        };
      case ContactApiVersion.jscontact:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapCard,
        };
    }
  }

  @override
  List<Object?> get props => [
        methodName,
        accountId,
        ids,
        properties,
        requiredCapabilities,
        apiVersion,
      ];

  factory GetContactMethod.fromJson(Map<String, dynamic> json) =>
      _$GetContactMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetContactMethodToJson(this);
}
