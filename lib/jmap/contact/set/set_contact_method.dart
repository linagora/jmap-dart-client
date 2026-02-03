import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/set/set_method_properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/contact.dart';
import 'package:jmap_dart_client/jmap/contact/card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/set_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

class SetContactMethod<T extends Contact> extends SetMethod<T> {
  final ContactApiVersion apiVersion;

  SetContactMethod(
    AccountId accountId, {
    this.apiVersion = ContactApiVersion.jscontact,
  }) : super(accountId);

  @override
  MethodName get methodName {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
        return MethodName('ContactCard/set');
      case ContactApiVersion.cyrus:
        return MethodName('Contact/set');
      case ContactApiVersion.jscontact:
        return MethodName('Card/set');
    }
  }

  @override
  Set<CapabilityIdentifier> get requiredCapabilities {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapContactCard,
        };
      case ContactApiVersion.cyrus:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapCyrusContact,
        };
      case ContactApiVersion.jscontact:
        return {
          CapabilityIdentifier.jmapCore,
          CapabilityIdentifier.jmapCard,
        };
    }
  }

  Map<String, dynamic> _encodeCreate(T contact) {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
        final contactCard = contact as ContactCard;
        final map = contactCard.toJson();
        contactCard.validateAndRemoveIetfFields(map);
        return map;

      case ContactApiVersion.cyrus:
        return (contact as Card).toCyrusJson();

      case ContactApiVersion.jscontact:
        return (contact as Card).toJson();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('ifInState', ifInState?.value);

    if (create != null) {
      final map = <String, dynamic>{};
      create!.forEach((id, contact) {
        map[id.value] = _encodeCreate(contact);
      });
      writeNotNull('create', map);
    }

    if (update != null) {
      writeNotNull(
        'update',
        update!.map(
          (id, patch) =>
              SetMethodPropertiesConverter().fromMapIdToJson(id, patch.toJson()),
        ),
      );
    }

    if (destroy != null) {
      writeNotNull(
        'destroy',
        destroy!.map((id) => const IdConverter().toJson(id)).toList(),
      );
    }

    return val;
  }

  @override
  List<Object?> get props => [
        accountId,
        apiVersion,
        ifInState,
        create,
        update,
        destroy,
      ];
}
