import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/changes/changes_contact_method.dart';
import 'package:jmap_dart_client/jmap/contact/changes/changes_contact_response.dart';
import 'package:jmap_dart_client/jmap/contact/contact.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/get/get_contact_method.dart';
import 'package:jmap_dart_client/jmap/contact/get/get_contact_response.dart';
import 'package:jmap_dart_client/jmap/contact/set/set_contact_method.dart';
import 'package:jmap_dart_client/jmap/contact/set/set_contact_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';

/// Utility class for creating, updating, deleting, and fetching contacts.
class ContactUtil {
  ContactUtil._();

  /// Sends create, update, or destroy contact operations.
  static Future<SetContactResponse> setContacts({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, Contact>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
    MethodCallId? methodCallId,
  }) async {
    final method = SetContactMethod(accountId, apiVersion: apiVersion);

    if (create != null && create.isNotEmpty) {
      method.addCreates(create);
    }
    if (update != null && update.isNotEmpty) {
      method.addUpdates(update);
    }
    if (destroy != null && destroy.isNotEmpty) {
      method.addDestroy(destroy);
    }

    return _executeSet(
      client,
      method,
      apiVersion,
      methodCallId: methodCallId,
    );
  }

  /// Fetches contacts from the server.
  static Future<GetContactResponse> getContacts({
    required HttpClient client,
    required AccountId accountId,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) async {
    final method = GetContactMethod(accountId, apiVersion: apiVersion);

    return _executeGetContact(
      client: client,
      accountId: accountId,
      method: method,
      apiVersion: apiVersion,
    );
  }

  /// Fetches one contact by id.
  static Future<Contact?> getContactById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
    required ContactApiVersion apiVersion,
  }) async {
    // JSContact servers crash when querying by id, so we fetch all and filter.
    if (apiVersion == ContactApiVersion.jscontact) {
      final all = await getContacts(
        client: client,
        accountId: accountId,
        apiVersion: apiVersion,
      );
      final match = all.list.where((c) => c.id?.value == id);
      return match.isEmpty ? null : match.first;
    }

    final method = GetContactMethod(accountId, apiVersion: apiVersion)
      ..ids = {Id(id)};

    final resp = await _executeGetContact(
      client: client,
      accountId: accountId,
      method: method,
      apiVersion: apiVersion,
    );
    if (resp.list.isEmpty) {
      return null;
    }

    return resp.list.first;
  }

  /// Internal helper for GetContact calls.
  static Future<GetContactResponse> _executeGetContact({
  required HttpClient client,
  required AccountId accountId,
  required GetContactMethod method,
  required ContactApiVersion apiVersion,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final resp = await (builder..usings(method.requiredCapabilities))
        .build()
        .execute();
        
    final parsed = resp.parse<GetContactResponse>(
      inv.methodCallId,
      (json) => GetContactResponse.deserialize(json, apiVersion: apiVersion),
    );

    if (parsed == null) {
      throw Exception('GetCarResponse parse failure');
    }

    return parsed;
  }

  /// Creates a new contact on the server.
  static Future<SetContactResponse> createContact({
    required HttpClient client,
    required AccountId accountId,
    required Contact contact,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) async {
    final cid = Id('contact-${DateTime.now().millisecondsSinceEpoch % 1000000}');

    final method = SetContactMethod(
      accountId,
      apiVersion: apiVersion,
    )..addCreate(cid, contact);

    return _executeSet(client, method, apiVersion);
  }


  /// Updates an existing contact.
  static Future<SetContactResponse> updateContact({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) async {
    final method = SetContactMethod(accountId, apiVersion: apiVersion)
      ..addUpdates({id: patch});

    return _executeSet(client, method, apiVersion);
  }

  /// Deletes a contact by id.
  static Future<SetContactResponse> deleteContact({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
  }) async {
    final method = SetContactMethod(accountId, apiVersion: apiVersion)
      ..addDestroy({id});

    return _executeSet(client, method, apiVersion);
  }

  /// Sends a changes request for contacts.
  static Future<ChangesContactResponse> changesContacts({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    ContactApiVersion apiVersion = ContactApiVersion.ietf,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesContactMethod(
      accountId,
      sinceState,
      maxChanges: maxChanges,
      apiVersion: apiVersion,
    );

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<ChangesContactResponse>(
      inv.methodCallId,
      (json) => ChangesContactResponse.deserialize(
        json,
        apiVersion: apiVersion,
      ),
    );

    if (parsed == null) {
      throw Exception('ChangesCardResponse parse failure');
    }

    return parsed;
  }

  /// Executes a SetContactMethod request and returns its response.
  static Future<SetContactResponse> _executeSet(
    HttpClient client,
    SetContactMethod method,
    ContactApiVersion apiVersion, {
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());

    final inv = builder.invocation(
      method,
      methodCallId: methodCallId,
    );

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetContactResponse>(
      inv.methodCallId,
      (json) => SetContactResponse.deserialize(json, apiVersion: apiVersion),
    );
    
    if (parsed == null) {
      throw Exception('SetContactResponse parse failure');
    }
    return parsed;
  }
}
