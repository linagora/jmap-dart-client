import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/http/converter/state_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/set_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';

class SetIdentityResponse extends SetResponse<Identity> {
  SetIdentityResponse(
    AccountId accountId,
    State newState, {
      State? oldState,
      Map<Id, Identity>? created,
      Map<Id, Identity?>? updated,
      Set<Id>? destroyed,
      Map<Id, SetError>? notCreated,
      Map<Id, SetError>? notUpdated,
      Map<Id, SetError>? notDestroyed
  }) : super(
    accountId,
    newState,
    oldState: oldState,
    created: created,
    updated: updated,
    destroyed: destroyed,
    notCreated: notCreated,
    notUpdated: notUpdated,
    notDestroyed: notDestroyed
  );

  static SetIdentityResponse deserialize(Map<String, dynamic> json) {
    return SetIdentityResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['newState'] as String),
      oldState: StateNullableConverter().fromJson(json['oldState'] as String?),
      created: (json['created'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            Identity.fromJson(value as Map<String, dynamic>))),
      updated: (json['updated'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            value != null ? Identity.fromJson(value as Map<String, dynamic>) : null)),
      destroyed: (json['destroyed'] as List<dynamic>?)
        ?.map((id) => IdConverter().fromJson(id)).toSet(),
      notCreated: (json['notCreated'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            SetError.fromJson(value))),
      notUpdated: (json['notUpdated'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            SetError.fromJson(value))),
      notDestroyed: (json['notDestroyed'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            SetError.fromJson(value))),
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
    notDestroyed
  ];
}