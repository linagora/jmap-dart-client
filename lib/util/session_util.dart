import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/session/get_session.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';

class SessionUtil {
  SessionUtil._();

  /// Fetches the JMAP session from the server.
  static Future<Session> getSession({
    required HttpClient client,
    bool useWellKnown = false,
  }) {
    return GetSessionBuilder(client, useWellKnown: useWellKnown)
        .build()
        .execute();
  }
}

/// Context and utility to create a live JMAP client.
class JmapLiveClient {
  final Dio dio;
  final HttpClient httpClient;
  final AccountId accountId;
  final Session session;
  final Map<Uri, CapabilityProperties> capabilities;
  final String? downloadTemplate;

  JmapLiveClient(
    this.dio,
    this.httpClient,
    this.accountId,
    this.session,
    this.capabilities,
    this.downloadTemplate,
  );
}

/// Creates an authenticated JMAP client and returns session details,
/// accountId, and the optional download URL template from the server.
Future<JmapLiveClient> createLiveClientFromFile({
  required String credentialsPath,
  String httpMethod = 'POST',
}) async {
  final file = File(credentialsPath);

  if (!file.existsSync()) {
    throw Exception('Credentials file not found: $credentialsPath');
  }

  final raw = await file.readAsString();
  if (raw.trim().isEmpty) {
    throw Exception('Credentials file is empty: $credentialsPath');
  }

  final creds = jsonDecode(raw) as Map<String, dynamic>;
  return _createLiveClientFromCreds(
    creds: creds,
    httpMethod: httpMethod,
  );
}

Future<JmapLiveClient> createLiveClientFromJson({
  required String credentialsJson,
  String httpMethod = 'POST',
}) async {
  final raw = credentialsJson.trim();
  if (raw.isEmpty) {
    throw Exception('Credentials JSON is empty');
  }

  final creds = jsonDecode(raw) as Map<String, dynamic>;
  return _createLiveClientFromCreds(
    creds: creds,
    httpMethod: httpMethod,
  );
}

Future<JmapLiveClient> _createLiveClientFromCreds({
  required Map<String, dynamic> creds,
  required String httpMethod,
}) async {
  final baseUrl = creds['url'];
  if (baseUrl == null || baseUrl is! String) {
    throw Exception('Missing or invalid "url" in credentials');
  }

  late final String authorizationHeader;

  if (creds['token'] != null) {
    authorizationHeader = 'Bearer ${creds['token']}';
  } else if (creds['username'] != null && creds['password'] != null) {
    authorizationHeader = 'Basic ${base64Encode(
      utf8.encode('${creds['username']}:${creds['password']}'),
    )}';
  } else {
    throw Exception('Credentials must contain either token or username/password');
  }

  final dio = Dio(
    BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl,
      headers: {
        'authorization': authorizationHeader,
        'content-type': 'application/json; charset=utf-8',
        'accept': 'application/json;jmapVersion=rfc-8621',
      },
    ),
  );

  final httpClient = HttpClient(dio);

  final session = await SessionUtil.getSession(
    client: httpClient,
    useWellKnown: false,
  );

  /// Updates the Dio base URL to the JMAP API endpoint if the session API URL
  /// is an absolute HTTP or HTTPS URL.
  final apiUrl = session.apiUrl.toString();
  if (apiUrl.startsWith('http://') || apiUrl.startsWith('https://')) {
    dio.options.baseUrl = apiUrl;
  }

  final accountId = AccountId(
    Id(session.accounts.keys.first.id.value),
  );

  final caps = session.capabilities.map(
    (key, value) => MapEntry(key.value, value),
  );

  return JmapLiveClient(
    dio,
    httpClient,
    accountId,
    session,
    caps,
    session.downloadUrl.toString(),
  );
}
