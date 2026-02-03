import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/address_book/address_book.dart';
import 'package:jmap_dart_client/jmap/address_book/changes/changes_address_book_method.dart';
import 'package:jmap_dart_client/jmap/address_book/changes/changes_address_book_response.dart';
import 'package:jmap_dart_client/jmap/address_book/get/get_address_book_method.dart';
import 'package:jmap_dart_client/jmap/address_book/get/get_address_book_response.dart';
import 'package:jmap_dart_client/jmap/address_book/set/set_address_book_method.dart';
import 'package:jmap_dart_client/jmap/address_book/set/set_address_book_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

class AddressBookUtil {
  AddressBookUtil._();

  static Future<SetAddressBookResponse> setAddressBooks({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, AddressBook>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    MethodCallId? methodCallId,
  }) async {
    final method = SetAddressBookMethod(accountId);

    if (create != null && create.isNotEmpty) {
      method.addCreates(create);
    }
    if (update != null && update.isNotEmpty) {
      method.addUpdates(update);
    }
    if (destroy != null && destroy.isNotEmpty) {
      method.addDestroy(destroy);
    }

    return _executeSet(client, method, methodCallId: methodCallId);
  }

  static Future<GetAddressBookResponse> getAddressBooks({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final method = GetAddressBookMethod(accountId);
    return _executeGet(client: client, method: method);
  }

  static Future<AddressBook?> getAddressBookById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = GetAddressBookMethod(accountId)..ids = {Id(id)};

    final resp = await _executeGet(client: client, method: method);
    if (resp.list.isEmpty) {
      return null;
    }
    return resp.list.first;
  }

  static Future<ChangesAddressBookResponse> changesAddressBooks({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesAddressBookMethod(
      accountId,
      sinceState,
      maxChanges: maxChanges,
    );

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<ChangesAddressBookResponse>(
      inv.methodCallId,
      ChangesAddressBookResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }

  static Future<SetAddressBookResponse> createAddressBook({
    required HttpClient client,
    required AccountId accountId,
    required AddressBook addressBook,
  }) async {
    final cid =
        Id('addressbook-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetAddressBookMethod(accountId)
      ..addCreate(cid, addressBook);

    return _executeSet(client, method);
  }

  static Future<SetAddressBookResponse> updateAddressBook({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) async {
    final method = SetAddressBookMethod(accountId)
      ..addUpdates({id: patch});

    return _executeSet(client, method);
  }

  static Future<SetAddressBookResponse> deleteAddressBook({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
  }) async {
    final method = SetAddressBookMethod(accountId)..addDestroy({id});
    return _executeSet(client, method);
  }

  static Future<GetAddressBookResponse> _executeGet({
    required HttpClient client,
    required GetAddressBookMethod method,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<GetAddressBookResponse>(
      inv.methodCallId,
      GetAddressBookResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }

  static Future<SetAddressBookResponse> _executeSet(
    HttpClient client,
    SetAddressBookMethod method, {
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetAddressBookResponse>(
      inv.methodCallId,
      SetAddressBookResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }
}
