import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/changes/changes_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/changes/changes_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission_id.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/set/set_email_submission_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/set/set_email_submission_response.dart';

class EmailUtil {
  EmailUtil._();

  /// Fetches emails, optionally filtered to specific [ids].
  static Future<GetEmailResponse> getEmails({
    required HttpClient client,
    required AccountId accountId,
    Set<Id>? ids,
    MethodCallId? methodCallId,
  }) async {
    final method = GetEmailMethod(accountId);
    if (ids != null) method.ids = ids;

    return _executeGet(client: client, method: method, methodCallId: methodCallId);
  }

  /// Fetches a single email by its id. Returns null if not found.
  static Future<Email?> getEmailById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final resp = await getEmails(
      client: client,
      accountId: accountId,
      ids: {Id(id)},
    );
    return resp.list.isEmpty ? null : resp.list.first;
  }

  /// Sends create, update, or destroy email operations.
  static Future<SetEmailResponse> setEmails({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, Email>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    MethodCallId? methodCallId,
  }) async {
    final method = SetEmailMethod(accountId);

    if (create != null && create.isNotEmpty) method.addCreates(create);
    if (update != null && update.isNotEmpty) method.addUpdates(update);
    if (destroy != null && destroy.isNotEmpty) method.addDestroy(destroy);

    return _executeSet(client: client, method: method, methodCallId: methodCallId);
  }

  /// Creates a new email.
  static Future<SetEmailResponse> createEmail({
    required HttpClient client,
    required AccountId accountId,
    required Email email,
  }) async {
    final cid = Id('email-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetEmailMethod(accountId)..addCreate(cid, email);
    return _executeSet(client: client, method: method);
  }

  /// Updates an email by applying a patch.
  static Future<SetEmailResponse> updateEmail({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) async {
    final method = SetEmailMethod(accountId)..addUpdates({id: patch});
    return _executeSet(client: client, method: method);
  }

  /// Deletes an email by id.
  static Future<SetEmailResponse> deleteEmail({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
  }) async {
    final method = SetEmailMethod(accountId)..addDestroy({id});
    return _executeSet(client: client, method: method);
  }

  /// Queries email ids matching the given [filter], with optional [limit].
  static Future<QueryEmailResponse> queryEmails({
    required HttpClient client,
    required AccountId accountId,
    EmailFilterCondition? filter,
    UnsignedInt? limit,
    bool? collapseThreads,
    MethodCallId? methodCallId,
  }) async {
    final method = QueryEmailMethod(accountId);
    if (filter != null) method.filter = filter;
    if (limit != null) method.limit = limit;
    if (collapseThreads != null) method.addCollapseThreads(collapseThreads);

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<QueryEmailResponse>(
      inv.methodCallId,
      QueryEmailResponse.deserialize,
    );

    if (parsed == null) throw Exception('QueryEmailResponse parse failure');
    return parsed;
  }

  /// Sends a changes request to detect which emails changed since [sinceState].
  static Future<ChangesEmailResponse> changesEmails({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesEmailMethod(accountId, sinceState, maxChanges: maxChanges);

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<ChangesEmailResponse>(
      inv.methodCallId,
      ChangesEmailResponse.deserialize,
    );

    if (parsed == null) throw Exception('ChangesEmailResponse parse failure');
    return parsed;
  }

  /// Submits an email for delivery via EmailSubmission/set.
  ///
  /// [submission] must have [emailId] set. Use [onSuccessUpdateEmail] to
  /// atomically update the email (e.g. set `$sent` keyword) on success.
  static Future<SetEmailSubmissionResponse> sendEmail({
    required HttpClient client,
    required AccountId accountId,
    required EmailSubmission submission,
    Map<EmailSubmissionId, PatchObject>? onSuccessUpdateEmail,
    MethodCallId? methodCallId,
  }) async {
    final cid = Id('sub-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetEmailSubmissionMethod(accountId)
      ..addCreate(cid, submission);

    if (onSuccessUpdateEmail != null) {
      method.addOnSuccessUpdateEmail(onSuccessUpdateEmail);
    }

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetEmailSubmissionResponse>(
      inv.methodCallId,
      SetEmailSubmissionResponse.deserialize,
    );

    if (parsed == null) throw Exception('SetEmailSubmissionResponse parse failure');
    return parsed;
  }

  static Future<GetEmailResponse> _executeGet({
    required HttpClient client,
    required GetEmailMethod method,
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<GetEmailResponse>(
      inv.methodCallId,
      GetEmailResponse.deserialize,
    );

    if (parsed == null) throw Exception('GetEmailResponse parse failure');
    return parsed;
  }

  static Future<SetEmailResponse> _executeSet({
    required HttpClient client,
    required SetEmailMethod method,
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp = await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetEmailResponse>(
      inv.methodCallId,
      SetEmailResponse.deserialize,
    );

    if (parsed == null) throw Exception('SetEmailResponse parse failure');
    return parsed;
  }
}
