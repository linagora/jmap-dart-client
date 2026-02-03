import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_method.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

class IdentityUtil {
  IdentityUtil._();

  static Future<GetIdentityResponse> getIdentities({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final method = GetIdentityMethod(accountId);
    return _executeGet(client: client, method: method);
  }

  static Future<Identity?> getIdentityById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = GetIdentityMethod(accountId)..ids = {Id(id)};

    final resp = await _executeGet(
      client: client,
      method: method,
    );

    if (resp.list.isEmpty) {
      return null;
    }

    return resp.list.first;
  }

  static Future<GetIdentityResponse> _executeGet({
    required HttpClient client,
    required GetIdentityMethod method,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final invocation = builder.invocation(method);

    final response =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = response.parse<GetIdentityResponse>(
      invocation.methodCallId,
      GetIdentityResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(response.toString());
    }

    return parsed;
  }
}
