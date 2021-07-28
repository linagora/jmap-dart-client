import 'dart:convert';

import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';

class GetSession {
  final String jsonSession = '''
  {
    "capabilities": {
      "urn:ietf:params:jmap:mail": {
        "maxMailboxesPerEmail": 10000000,
        "maxMailboxDepth": null,
        "maxSizeMailboxName": 200,
        "maxSizeAttachmentsPerEmail": 20000000,
        "emailQuerySortOptions": [
          "receivedAt",
          "sentAt",
          "size",
          "from",
          "to",
          "subject"
        ],
        "mayCreateTopLevelMailbox": true
      },
      "urn:ietf:params:jmap:submission": {
        "maxDelayedSend": 0,
        "submissionExtensions": []
      },
      "urn:ietf:params:jmap:core": {
        "maxSizeUpload": 31457280,
        "maxConcurrentUpload": 4,
        "maxSizeRequest": 10000000,
        "maxConcurrentRequests": 4,
        "maxCallsInRequest": 16,
        "maxObjectsInGet": 500,
        "maxObjectsInSet": 500,
        "collationAlgorithms": [
          "i;unicode-casemap"
        ]
      }
    },
    "accounts": {
      "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba": {
        "name": "benoit@localhost",
        "isPersonal": true,
        "isReadOnly": false,
        "accountCapabilities": {
          "urn:ietf:params:jmap:mail": {
            "maxMailboxesPerEmail": 10000000,
            "maxMailboxDepth": null,
            "maxSizeMailboxName": 200,
            "maxSizeAttachmentsPerEmail": 20000000,
            "emailQuerySortOptions": [
              "receivedAt",
              "sentAt",
              "size",
              "from",
              "to",
              "subject"
            ],
            "mayCreateTopLevelMailbox": true
          },
          "urn:ietf:params:jmap:websocket": {
            "supportsPush": true,
            "url": "http://localhost/jmap/ws"
          },
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": []
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 31457280,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
              "collationAlgorithms": ["i;unicode-casemap"]
            },
            "urn:ietf:params:jmap:vacationresponse": {}
        }
      }
    },
    "primaryAccounts": {
      "urn:ietf:params:jmap:submission":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "com:linagora:params:jmap:pgp":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:ietf:params:jmap:websocket":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "com:linagora:params:jmap:ws:ticket":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:apache:james:params:jmap:mail:shares":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:ietf:params:jmap:vacationresponse":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:ietf:params:jmap:mail":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "com:linagora:params:jmap:filter":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:ietf:params:jmap:mdn":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:apache:james:params:jmap:mail:quota":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "urn:ietf:params:jmap:core":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba",
      "com:linagora:params:jmap:echo":
          "2bdee8dcc7f7a6817e2699d21c0462f3ab0b66d25de7e71ae2762d4ae8c591ba"
    },
    "username": "alice@localhost",
    "apiUrl": "http://localhost/jmap",
    "downloadUrl": "http://localhost/download/{accountId}/{blobId}/?type={type}&name={name}",
    "uploadUrl": "http://localhost/upload/{accountId}",
    "eventSourceUrl": "http://localhost/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
    "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
  }
  ''';

  final HttpClient _httpClient;

  GetSession(this._httpClient);

  final CapabilitiesConverter _capabilitiesConverter = CapabilitiesConverter();

  void registerCapabilityConverter(Map<CapabilityIdentifier, CapabilityProperties Function(Map<String, dynamic>)> converters) {
    _capabilitiesConverter.addConverters(converters);
  }

  Future<Session> execute() async {
    return await getFakeSession()
      .then((value) => Session.fromJson(value, converter: _capabilitiesConverter))
      .catchError((error) => throw error);
  }

  Future<Map<String, dynamic>> getFakeSession() async {
    final session = json.decode(jsonSession);
    return Future.value(session);
  }
}