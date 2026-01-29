import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/changes_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

part 'changes_contact_method.g.dart';

@UnsignedIntNullableConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class ChangesContactMethod extends ChangesMethod {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ContactApiVersion apiVersion;

  ChangesContactMethod(
    AccountId accountId,
    State sinceState, {
    UnsignedInt? maxChanges,
    this.apiVersion = ContactApiVersion.jscontact,
  }) : super(accountId, sinceState, maxChanges: maxChanges);


  @override
  MethodName get methodName {
    switch (apiVersion) {
      case ContactApiVersion.cyrus:
        return MethodName('Contact/changes');
      case ContactApiVersion.ietf:
        return MethodName('ContactCard/changes');
      case ContactApiVersion.jscontact:
        return MethodName('Card/changes'); //not supported yet for NC and Roundcube
    }
  }

  @override
  List<Object?> get props => [accountId, sinceState, maxChanges, apiVersion];

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
        case ContactApiVersion.jscontact: //not supported yet for NC and Roundcube
          return {
            CapabilityIdentifier.jmapCore,
            CapabilityIdentifier.jmapCard,
          };
      }
    }

  factory ChangesContactMethod.fromJson(Map<String, dynamic> json) => _$ChangesContactMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangesContactMethodToJson(this);
}
