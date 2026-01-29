import 'package:jmap_dart_client/http/converter/state_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/contact/contact.dart';
import 'package:jmap_dart_client/jmap/contact/card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/core/method/response/set_response.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';

class SetContactResponse<T extends Contact> extends SetResponse<T> {
  final ContactApiVersion apiVersion;

  SetContactResponse(
    AccountId accountId, {
    this.apiVersion = ContactApiVersion.jscontact,
    State? newState,
    State? oldState,
    Map<Id, T>? created,
    Map<Id, T?>? updated,
    Set<Id>? destroyed,
    Map<Id, SetError>? notCreated,
    Map<Id, SetError>? notUpdated,
    Map<Id, SetError>? notDestroyed,
  }) : super(
          accountId,
          newState: newState,
          oldState: oldState,
          created: created,
          updated: updated,
          destroyed: destroyed,
          notCreated: notCreated,
          notUpdated: notUpdated,
          notDestroyed: notDestroyed,
        );

  static SetContactResponse<Contact> deserialize(
    Map<String, dynamic> json, {
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) {
    const idConverter = IdConverter();

    Contact? parseContact(dynamic data) {
      if (data is! Map<String, dynamic>) return null;

      switch (apiVersion) {
        case ContactApiVersion.ietf:
          return ContactCard.fromJson(data);
        case ContactApiVersion.cyrus:
          return Card.fromCyrusJson(data);
        case ContactApiVersion.jscontact:
          return Card.fromJson(data, apiVersion: apiVersion);
      }
    }

    Map<Id, Contact>? mapContacts(Map<String, dynamic>? source) {
      if (source == null) return null;

      final result = <Id, Contact>{};
      for (final entry in source.entries) {
        final contact = parseContact(entry.value);
        if (contact != null) {
          result[idConverter.fromJson(entry.key.toString())] = contact;
        }
      }
      return result;
    }

    return SetContactResponse<Contact>(
      const AccountIdConverter().fromJson(json['accountId'].toString()),
      apiVersion: apiVersion,
      newState:
          const StateNullableConverter().fromJson(json['newState'] as String?),
      oldState:
          const StateNullableConverter().fromJson(json['oldState'] as String?),
      created: mapContacts(json['created'] as Map<String, dynamic>?),
      updated: mapContacts(json['updated'] as Map<String, dynamic>?),
      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((e) => idConverter.fromJson(e.toString()))
          .toSet(),
      notCreated: (json['notCreated'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          idConverter.fromJson(k.toString()),
          SetError.fromJson(v),
        ),
      ),
      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          idConverter.fromJson(k.toString()),
          SetError.fromJson(v),
        ),
      ),
      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          idConverter.fromJson(k.toString()),
          SetError.fromJson(v),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [
        oldState,
        newState,
        created,
        updated,
        destroyed,
        notCreated,
        notUpdated,
        notDestroyed,
        apiVersion,
      ];
}
