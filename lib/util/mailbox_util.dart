import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/changes/changes_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/changes/changes_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/query/query_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/query/query_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/set/set_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/set/set_mailbox_response.dart';

class MailboxUtil {
  MailboxUtil._();

  /// Fetches all mailboxes, optionally filtered to specific [ids].
  static Future<GetMailboxResponse> getMailboxes({
    required HttpClient client,
    required AccountId accountId,
    Set<Id>? ids,
    MethodCallId? methodCallId,
  }) async {
    final method = GetMailboxMethod(accountId);
    if (ids != null) method.ids = ids;

    return _executeGet(client: client, method: method, methodCallId: methodCallId);
  }

  /// Fetches a single mailbox by its id. Returns null if not found.
  static Future<Mailbox?> getMailboxById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final resp = await getMailboxes(
      client: client,
      accountId: accountId,
      ids: {Id(id)},
    );
    return resp.list.isEmpty ? null : resp.list.first;
  }

  /// Sends create, update, or destroy mailbox operations.
  static Future<SetMailboxResponse> setMailboxes({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, Mailbox>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    bool? onDestroyRemoveEmails,
    MethodCallId? methodCallId,
  }) async {
    final method = SetMailboxMethod(accountId);

    if (create != null && create.isNotEmpty) method.addCreates(create);
    if (update != null && update.isNotEmpty) method.addUpdates(update);
    if (destroy != null && destroy.isNotEmpty) method.addDestroy(destroy);
    if (onDestroyRemoveEmails != null) {
      method.addOnDestroyRemoveEmails(onDestroyRemoveEmails);
    }

    return _executeSet(client: client, method: method, methodCallId: methodCallId);
  }

  /// Creates a new mailbox.
  static Future<SetMailboxResponse> createMailbox({
    required HttpClient client,
    required AccountId accountId,
    required Mailbox mailbox,
  }) async {
    final cid = Id('mbox-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetMailboxMethod(accountId)..addCreate(cid, mailbox);
    return _executeSet(client: client, method: method);
  }

  /// Updates a mailbox by applying a patch.
  static Future<SetMailboxResponse> updateMailbox({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) async {
    final method = SetMailboxMethod(accountId)..addUpdates({id: patch});
    return _executeSet(client: client, method: method);
  }

  /// Deletes a mailbox by id.
  ///
  /// Set [removeEmails] to true to also delete all emails within the mailbox.
  static Future<SetMailboxResponse> deleteMailbox({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    bool removeEmails = false,
  }) async {
    final method = SetMailboxMethod(accountId)
      ..addDestroy({id})
      ..addOnDestroyRemoveEmails(removeEmails);
    return _executeSet(client: client, method: method);
  }

  /// Queries mailboxes matching the given [filter].
  static Future<QueryMailboxResponse> queryMailboxes({
    required HttpClient client,
    required AccountId accountId,
    MailboxFilterCondition? filter,
    UnsignedInt? limit,
    bool? sortAsTree,
    bool? filterAsTree,
    MethodCallId? methodCallId,
  }) async {
    final method = QueryMailboxMethod(accountId);
    if (filter != null) method.filter = filter;
    if (limit != null) method.limit = limit;
    if (sortAsTree != null) method.addSortAsTree(sortAsTree);
    if (filterAsTree != null) method.addFilterAsTree(filterAsTree);

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<QueryMailboxResponse>(
      inv.methodCallId,
      QueryMailboxResponse.deserialize,
    );

    if (parsed == null) throw Exception('QueryMailboxResponse parse failure');
    return parsed;
  }

  /// Sends a changes request to detect which mailboxes changed since [sinceState].
  static Future<ChangesMailboxResponse> changesMailboxes({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesMailboxMethod(accountId, sinceState, maxChanges: maxChanges);

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<ChangesMailboxResponse>(
      inv.methodCallId,
      ChangesMailboxResponse.deserialize,
    );

    if (parsed == null) throw Exception('ChangesMailboxResponse parse failure');
    return parsed;
  }

  static Future<GetMailboxResponse> _executeGet({
    required HttpClient client,
    required GetMailboxMethod method,
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<GetMailboxResponse>(
      inv.methodCallId,
      GetMailboxResponse.deserialize,
    );

    if (parsed == null) throw Exception('GetMailboxResponse parse failure');
    return parsed;
  }

  static Future<SetMailboxResponse> _executeSet({
    required HttpClient client,
    required SetMailboxMethod method,
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetMailboxResponse>(
      inv.methodCallId,
      SetMailboxResponse.deserialize,
    );

    if (parsed == null) throw Exception('SetMailboxResponse parse failure');
    return parsed;
  }
}
