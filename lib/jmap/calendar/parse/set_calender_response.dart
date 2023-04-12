import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/set_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';

class SetCalenderResponse extends SetResponse<Email> {
  SetCalenderResponse(
    AccountId accountId, {
      State? newState,
      State? oldState,
      Map<Id, Email>? created,
      Map<Id, Email?>? updated,
      Set<Id>? destroyed,
      Map<Id, SetError>? notCreated,
      Map<Id, SetError>? notUpdated,
      Map<Id, SetError>? notDestroyed
  }) : super(
    accountId,
    newState: newState,
    oldState: oldState,
    created: created,
    updated: updated,
    destroyed: destroyed,
    notCreated: notCreated,
    notUpdated: notUpdated,
    notDestroyed: notDestroyed
  );

  static SetCalenderResponse deserialize(Map<String, dynamic> json) {
    return SetCalenderResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      newState: StateNullableConverter().fromJson(json['newState'] as String?),
      oldState: StateNullableConverter().fromJson(json['oldState'] as String?),
      created: (json['created'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            Email.fromJson(value as Map<String, dynamic>))),
      updated: (json['updated'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(
            IdConverter().fromJson(key),
            value != null ? Email.fromJson(value as Map<String, dynamic>) : null)),
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