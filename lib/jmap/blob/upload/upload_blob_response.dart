import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/blob/blob.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/set_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';

class UploadBlobResponse extends SetResponse<Blob> {
  UploadBlobResponse(
    AccountId accountId, {
    State? newState,
    State? oldState,
    Map<Id, Blob>? created,
    Map<Id, Blob?>? updated,
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
  static UploadBlobResponse deserialize(Map<String, dynamic> json) {
    const idConv = IdConverter();
    const accConv = AccountIdConverter();

    // parse created 
    Map<Id, Blob>? parseCreated(Map<String, dynamic>? map) {
      if (map == null) return null;
      final out = <Id, Blob>{};
      map.forEach((key, value) {
        out[idConv.fromJson(key)] = Blob.fromJson(value);
      });
      return out;
    }

    // parse updated (rarely used for Blob/upload) 
    Map<Id, Blob?>? parseUpdated(Map<String, dynamic>? map) {
      if (map == null) return null;
      final out = <Id, Blob?>{};
      map.forEach((key, value) {
        out[idConv.fromJson(key)] =
            value == null ? null : Blob.fromJson(value);
      });
      return out;
    }

    return UploadBlobResponse(
      accConv.fromJson(json['accountId']),
      newState: json['newState'] != null
          ? const StateNullableConverter().fromJson(json['newState'])
          : null,
      oldState: json['oldState'] != null
          ? const StateNullableConverter().fromJson(json['oldState'])
          : null,
      created: parseCreated(json['created']),
      updated: parseUpdated(json['updated']),
      destroyed: (json['destroyed'] as List<dynamic>?)
          ?.map((e) => idConv.fromJson(e))
          .toSet(),
      notCreated: json['notCreated']?.map(
              (k, v) => MapEntry(idConv.fromJson(k), SetError.fromJson(v))),
      notUpdated: json['notUpdated']?.map(
              (k, v) => MapEntry(idConv.fromJson(k), SetError.fromJson(v))),
      notDestroyed: json['notDestroyed']?.map(
              (k, v) => MapEntry(idConv.fromJson(k), SetError.fromJson(v))),
    );
  }

  @override
  List<Object?> get props => [
        accountId,
        oldState,
        newState,
        created,
        updated,
        destroyed,
        notCreated,
        notUpdated,
        notDestroyed,
      ];
}
