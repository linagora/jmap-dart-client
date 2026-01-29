import 'package:jmap_dart_client/jmap/contact/contact.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';

part 'get_contact_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable() 
class GetContactResponse extends GetResponse<Contact> {
  final ContactApiVersion apiVersion;

  GetContactResponse(
    AccountId accountId,
    State state,
    List<Contact> list,
    List<Id>? notFound, {
    this.apiVersion = ContactApiVersion.jscontact,
  }) : super(accountId, state, list, notFound);

  /// Creates a GetContactResponse by decoding the raw JSON and parsing the list
  /// according to the selected API version.
  factory GetContactResponse.fromJson(
    Map<String, dynamic> json, {
    required ContactApiVersion apiVersion,
  }) {
    final accountId =
        const AccountIdConverter().fromJson(json['accountId'] as String);

    final stateJson = json['state']; // may be null for jscontact
    final state = stateJson == null
        ?  State('') // default when server omits state
        : const StateConverter().fromJson(stateJson as String);

    final notFound = (json['notFound'] as List<dynamic>?)
        ?.map((e) => const IdConverter().fromJson(e as String))
        .toList();

    final list = _parseList(json, apiVersion);

    return GetContactResponse(
      accountId,
      state,
      list,
      notFound,
      apiVersion: apiVersion,
    );
  }

  // Parses the list of contacts from a response according to the API version.
  static List<Contact> _parseList(
    Map<String, dynamic> json,
    ContactApiVersion apiVersion,
  ) {
    final rawList = json['list'] as List<dynamic>? ?? [];

    switch (apiVersion) {
      case ContactApiVersion.ietf:
        return rawList
            .map((e) => ContactCard.fromJson(e as Map<String, dynamic>))
            .toList();

      case ContactApiVersion.cyrus:
      case ContactApiVersion.jscontact:
      default:
        return rawList
            .map((e) => Card.fromJson(
                  e as Map<String, dynamic>,
                  apiVersion: apiVersion,
                ))
            .toList();
    }
  }

  /// Deserializes a GetContactResponse using the specified API version.
  static GetContactResponse deserialize(
    Map<String, dynamic> json, {
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) =>
      GetContactResponse.fromJson(json, apiVersion: apiVersion);

  Map<String, dynamic> toJson() => _$GetContactResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound, apiVersion];
}
