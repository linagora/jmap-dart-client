import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/account/account.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/core_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/default_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/mail_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/mdn_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/submission_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/vacation_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/websocket_capability.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';
import 'package:jmap_dart_client/jmap/core/sort/collation_identifier.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/user_name.dart';

import 'test_capability.dart';

void main() {
  group('get session with default capabilities', () {
    test('get should parsing correctly session', () {
      final sessionString = '''{
        "capabilities": {
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": {}
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 20971520,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
            "collationAlgorithms": [
              "i;unicode-casemap"
            ]
          },
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
            "url": "ws://domain.com/jmap/ws"
          },
          "urn:apache:james:params:jmap:mail:quota": {},
          "urn:apache:james:params:jmap:mail:shares": {},
          "urn:ietf:params:jmap:vacationresponse": {},
          "urn:ietf:params:jmap:mdn": {}
        },
        "accounts": {
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6": {
            "name": "bob@domain.tld",
            "isPersonal": true,
            "isReadOnly": false,
            "accountCapabilities": {
              "urn:ietf:params:jmap:submission": {
                "maxDelayedSend": 0,
                "submissionExtensions": {}
              },
              "urn:ietf:params:jmap:websocket": {
                "supportsPush": true,
                "url": "ws://domain.com/jmap/ws"
              },
              "urn:ietf:params:jmap:core": {
                "maxSizeUpload": 20971520,
                "maxConcurrentUpload": 4,
                "maxSizeRequest": 10000000,
                "maxConcurrentRequests": 4,
                "maxCallsInRequest": 16,
                "maxObjectsInGet": 500,
                "maxObjectsInSet": 500,
                "collationAlgorithms": [
                  "i;unicode-casemap"
                ]
              },
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
              "urn:apache:james:params:jmap:mail:quota": {},
              "urn:apache:james:params:jmap:mail:shares": {},
              "urn:ietf:params:jmap:vacationresponse": {},
              "urn:ietf:params:jmap:mdn": {}
            }
          }
        },
        "primaryAccounts": {
          "urn:ietf:params:jmap:submission": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:websocket": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:core": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mail": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:quota": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:shares": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:vacationresponse": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mdn": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6"
        },
        "username": "bob@domain.tld",
        "apiUrl": "http://domain.com/jmap",
        "downloadUrl": "http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}",
        "uploadUrl": "http://domain.com/upload/{accountId}",
        "eventSourceUrl": "http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
        "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
      }''';

      final Session expectedSession = Session(
        {
          CapabilityIdentifier.jmapSubmission: SubmissionCapability(
            maxDelayedSend: UnsignedInt(0),
            submissionExtensions: {}
          ),
          CapabilityIdentifier.jmapCore: CoreCapability(
            maxSizeUpload: UnsignedInt(20971520),
            maxConcurrentUpload: UnsignedInt(4),
            maxSizeRequest: UnsignedInt(10000000),
            maxConcurrentRequests: UnsignedInt(4),
            maxCallsInRequest: UnsignedInt(16),
            maxObjectsInGet: UnsignedInt(500),
            maxObjectsInSet: UnsignedInt(500),
            collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
          ),
          CapabilityIdentifier.jmapMail: MailCapability(
            maxMailboxesPerEmail: UnsignedInt(10000000),
            maxSizeMailboxName: UnsignedInt(200),
            maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
            emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
            mayCreateTopLevelMailbox: true
          ),
          CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
            supportsPush: true,
            url: Uri.parse('ws://domain.com/jmap/ws')
          ),
          CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
          CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
          CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
          CapabilityIdentifier.jmapMdn: MdnCapability()
        },
        {
          AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')): Account(
            AccountName('bob@domain.tld'),
            true,
            false,
            {
              CapabilityIdentifier.jmapSubmission: SubmissionCapability(
                maxDelayedSend: UnsignedInt(0),
                submissionExtensions: {}
              ),
              CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
                supportsPush: true,
                url: Uri.parse('ws://domain.com/jmap/ws')
              ),
              CapabilityIdentifier.jmapCore: CoreCapability(
                maxSizeUpload: UnsignedInt(20971520),
                maxConcurrentUpload: UnsignedInt(4),
                maxSizeRequest: UnsignedInt(10000000),
                maxConcurrentRequests: UnsignedInt(4),
                maxCallsInRequest: UnsignedInt(16),
                maxObjectsInGet: UnsignedInt(500),
                maxObjectsInSet: UnsignedInt(500),
                collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
              ),
              CapabilityIdentifier.jmapMail: MailCapability(
                maxMailboxesPerEmail: UnsignedInt(10000000),
                maxSizeMailboxName: UnsignedInt(200),
                maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
                emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
                mayCreateTopLevelMailbox: true
              ),
              CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
              CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
              CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
              CapabilityIdentifier.jmapMdn: MdnCapability()
            }
          )
        },
        {
          CapabilityIdentifier.jmapSubmission: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier.jmapWebSocket: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier.jmapCore: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier.jmapMail: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier.jmapVacationResponse: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          CapabilityIdentifier.jmapMdn: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
        },
        UserName('bob@domain.tld'),
        Uri.parse('http://domain.com/jmap'),
        Uri.parse('http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}'),
        Uri.parse('http://domain.com/upload/{accountId}'),
        Uri.parse('http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}'),
        State('2c9f1b12-b35a-43e6-9af2-0106fb53a943')
      );

      final parsedSession = Session.fromJson(json.decode(sessionString));

      expect(parsedSession, equals(expectedSession));
    });

    test('get should parsing correctly session with some limit capabilities', () {
      final sessionString = '''{
        "capabilities": {
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": {}
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 20971520,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
            "collationAlgorithms": [
              "i;unicode-casemap"
            ]
          },
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
          "urn:ietf:params:jmap:vacationresponse": {}
        },
        "accounts": {
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6": {
            "name": "bob@domain.tld",
            "isPersonal": true,
            "isReadOnly": false,
            "accountCapabilities": {
              "urn:ietf:params:jmap:submission": {
                "maxDelayedSend": 0,
                "submissionExtensions": {}
              },
              "urn:ietf:params:jmap:core": {
                "maxSizeUpload": 20971520,
                "maxConcurrentUpload": 4,
                "maxSizeRequest": 10000000,
                "maxConcurrentRequests": 4,
                "maxCallsInRequest": 16,
                "maxObjectsInGet": 500,
                "maxObjectsInSet": 500,
                "collationAlgorithms": [
                  "i;unicode-casemap"
                ]
              },
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
              "urn:ietf:params:jmap:vacationresponse": {}
            }
          }
        },
        "primaryAccounts": {
          "urn:ietf:params:jmap:submission": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:core": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mail": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:vacationresponse": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6"
        },
        "username": "bob@domain.tld",
        "apiUrl": "http://domain.com/jmap",
        "downloadUrl": "http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}",
        "uploadUrl": "http://domain.com/upload/{accountId}",
        "eventSourceUrl": "http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
        "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
      }''';

      final Session expectedSession = Session(
          {
            CapabilityIdentifier.jmapSubmission: SubmissionCapability(
              maxDelayedSend: UnsignedInt(0),
              submissionExtensions: {}
            ),
            CapabilityIdentifier.jmapCore: CoreCapability(
              maxSizeUpload: UnsignedInt(20971520),
              maxConcurrentUpload: UnsignedInt(4),
              maxSizeRequest: UnsignedInt(10000000),
              maxConcurrentRequests: UnsignedInt(4),
              maxCallsInRequest: UnsignedInt(16),
              maxObjectsInGet: UnsignedInt(500),
              maxObjectsInSet: UnsignedInt(500),
              collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
            ),
            CapabilityIdentifier.jmapMail: MailCapability(
              maxMailboxesPerEmail: UnsignedInt(10000000),
              maxSizeMailboxName: UnsignedInt(200),
              maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
              emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
              mayCreateTopLevelMailbox: true
            ),
            CapabilityIdentifier.jmapVacationResponse: VacationCapability()
          },
          {
            AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')): Account(
                AccountName('bob@domain.tld'),
                true,
                false,
                {
                  CapabilityIdentifier.jmapSubmission: SubmissionCapability(
                    maxDelayedSend: UnsignedInt(0),
                    submissionExtensions: {}
                  ),
                  CapabilityIdentifier.jmapCore: CoreCapability(
                    maxSizeUpload: UnsignedInt(20971520),
                    maxConcurrentUpload: UnsignedInt(4),
                    maxSizeRequest: UnsignedInt(10000000),
                    maxConcurrentRequests: UnsignedInt(4),
                    maxCallsInRequest: UnsignedInt(16),
                    maxObjectsInGet: UnsignedInt(500),
                    maxObjectsInSet: UnsignedInt(500),
                    collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
                  ),
                  CapabilityIdentifier.jmapMail: MailCapability(
                    maxMailboxesPerEmail: UnsignedInt(10000000),
                    maxSizeMailboxName: UnsignedInt(200),
                    maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
                    emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
                    mayCreateTopLevelMailbox: true
                  ),
                  CapabilityIdentifier.jmapVacationResponse: VacationCapability()
                }
            )
          },
          {
            CapabilityIdentifier.jmapSubmission: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapCore: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMail: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapVacationResponse: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6'))
          },
          UserName('bob@domain.tld'),
          Uri.parse('http://domain.com/jmap'),
          Uri.parse('http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}'),
          Uri.parse('http://domain.com/upload/{accountId}'),
          Uri.parse('http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}'),
          State('2c9f1b12-b35a-43e6-9af2-0106fb53a943')
      );

      final parsedSession = Session.fromJson(json.decode(sessionString));

      expect(parsedSession, equals(expectedSession));
    });
  });

  group('get session with unknown capability', () {
    test('get should parsing correctly session with default converter', () {
      final sessionString = '''{
        "capabilities": {
          "urn:tmail:custom:params:mailbox": {
            "param1": 1,
            "param2": "good",
            "param3": ["custom", "capability"]
          },
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": {}
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 20971520,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
            "collationAlgorithms": [
              "i;unicode-casemap"
            ]
          },
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
            "url": "ws://domain.com/jmap/ws"
          },
          "urn:apache:james:params:jmap:mail:quota": {},
          "urn:apache:james:params:jmap:mail:shares": {},
          "urn:ietf:params:jmap:vacationresponse": {},
          "urn:ietf:params:jmap:mdn": {}
        },
        "accounts": {
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6": {
            "name": "bob@domain.tld",
            "isPersonal": true,
            "isReadOnly": false,
            "accountCapabilities": {
              "urn:tmail:custom:params:mailbox": {
                "param1": 1,
                "param2": "good",
                "param3": ["custom", "capability"]
              },
              "urn:ietf:params:jmap:submission": {
                "maxDelayedSend": 0,
                "submissionExtensions": {}
              },
              "urn:ietf:params:jmap:websocket": {
                "supportsPush": true,
                "url": "ws://domain.com/jmap/ws"
              },
              "urn:ietf:params:jmap:core": {
                "maxSizeUpload": 20971520,
                "maxConcurrentUpload": 4,
                "maxSizeRequest": 10000000,
                "maxConcurrentRequests": 4,
                "maxCallsInRequest": 16,
                "maxObjectsInGet": 500,
                "maxObjectsInSet": 500,
                "collationAlgorithms": [
                  "i;unicode-casemap"
                ]
              },
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
              "urn:apache:james:params:jmap:mail:quota": {},
              "urn:apache:james:params:jmap:mail:shares": {},
              "urn:ietf:params:jmap:vacationresponse": {},
              "urn:ietf:params:jmap:mdn": {}
            }
          }
        },
        "primaryAccounts": {
          "urn:tmail:custom:params:mailbox": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:submission": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:websocket": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:core": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mail": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:quota": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:shares": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:vacationresponse": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mdn": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6"
        },
        "username": "bob@domain.tld",
        "apiUrl": "http://domain.com/jmap",
        "downloadUrl": "http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}",
        "uploadUrl": "http://domain.com/upload/{accountId}",
        "eventSourceUrl": "http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
        "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
      }''';
      final customCapabilityIdentifier = CapabilityIdentifier(Uri.parse('urn:tmail:custom:params:mailbox'));
      final customCapability = DefaultCapability(
          {
            "param1": 1,
            "param2": "good",
            "param3": {"custom", "capability"}.toList()
          }
      );

      final Session expectedSession = Session(
          {
            customCapabilityIdentifier: customCapability,
            CapabilityIdentifier.jmapSubmission: SubmissionCapability(
              maxDelayedSend: UnsignedInt(0),
              submissionExtensions: {}
            ),
            CapabilityIdentifier.jmapCore: CoreCapability(
              maxSizeUpload: UnsignedInt(20971520),
              maxConcurrentUpload: UnsignedInt(4),
              maxSizeRequest: UnsignedInt(10000000),
              maxConcurrentRequests: UnsignedInt(4),
              maxCallsInRequest: UnsignedInt(16),
              maxObjectsInGet: UnsignedInt(500),
              maxObjectsInSet: UnsignedInt(500),
              collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
            ),
            CapabilityIdentifier.jmapMail: MailCapability(
              maxMailboxesPerEmail: UnsignedInt(10000000),
              maxSizeMailboxName: UnsignedInt(200),
              maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
              emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
              mayCreateTopLevelMailbox: true
            ),
            CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
              supportsPush: true,
              url: Uri.parse('ws://domain.com/jmap/ws')
            ),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
            CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
            CapabilityIdentifier.jmapMdn: MdnCapability()
          },
          {
            AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')): Account(
                AccountName('bob@domain.tld'),
                true,
                false,
                {
                  customCapabilityIdentifier: customCapability,
                  CapabilityIdentifier.jmapSubmission: SubmissionCapability(
                    maxDelayedSend: UnsignedInt(0),
                    submissionExtensions: {}
                  ),
                  CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
                    supportsPush: true,
                    url: Uri.parse('ws://domain.com/jmap/ws')
                  ),
                  CapabilityIdentifier.jmapCore: CoreCapability(
                    maxSizeUpload: UnsignedInt(20971520),
                    maxConcurrentUpload: UnsignedInt(4),
                    maxSizeRequest: UnsignedInt(10000000),
                    maxConcurrentRequests: UnsignedInt(4),
                    maxCallsInRequest: UnsignedInt(16),
                    maxObjectsInGet: UnsignedInt(500),
                    maxObjectsInSet: UnsignedInt(500),
                    collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
                  ),
                  CapabilityIdentifier.jmapMail: MailCapability(
                    maxMailboxesPerEmail: UnsignedInt(10000000),
                    maxSizeMailboxName: UnsignedInt(200),
                    maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
                    emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
                    mayCreateTopLevelMailbox: true
                  ),
                  CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
                  CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
                  CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
                  CapabilityIdentifier.jmapMdn: MdnCapability()
                }
            )
          },
          {
            customCapabilityIdentifier: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapSubmission: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapWebSocket: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapCore: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMail: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapVacationResponse: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMdn: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          },
          UserName('bob@domain.tld'),
          Uri.parse('http://domain.com/jmap'),
          Uri.parse('http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}'),
          Uri.parse('http://domain.com/upload/{accountId}'),
          Uri.parse('http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}'),
          State('2c9f1b12-b35a-43e6-9af2-0106fb53a943')
      );

      final parsedSession = Session.fromJson(json.decode(sessionString));

      expect(parsedSession, equals(expectedSession));
      expect(parsedSession.capabilities[CapabilityIdentifier(Uri.parse('urn:tmail:custom:params:mailbox'))], equals(customCapability));
      expect(parsedSession.accounts.values.first
          .accountCapabilities[CapabilityIdentifier(Uri.parse('urn:tmail:custom:params:mailbox'))],
        equals(customCapability));
    });
  });

  group('get session with custom capability', () {
    test('get should parsing correctly with relevant custom converter', () {
      final sessionString = '''{
        "capabilities": {
          "urn:test:tmail:params:custom": {
            "testParam1": 100,
            "testParam2": "test",
            "testParam3": ["test", "capability"]
          },
          "urn:tmail:custom:params:mailbox": {
            "param1": 1,
            "param2": "good",
            "param3": ["custom", "capability"]
          },
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": {}
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 20971520,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
            "collationAlgorithms": [
              "i;unicode-casemap"
            ]
          },
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
            "url": "ws://domain.com/jmap/ws"
          },
          "urn:apache:james:params:jmap:mail:quota": {},
          "urn:apache:james:params:jmap:mail:shares": {},
          "urn:ietf:params:jmap:vacationresponse": {},
          "urn:ietf:params:jmap:mdn": {}
        },
        "accounts": {
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6": {
            "name": "bob@domain.tld",
            "isPersonal": true,
            "isReadOnly": false,
            "accountCapabilities": {
              "urn:tmail:custom:params:mailbox": {
                "param1": 1,
                "param2": "good",
                "param3": ["custom", "capability"]
              },
              "urn:ietf:params:jmap:submission": {
                "maxDelayedSend": 0,
                "submissionExtensions": {}
              },
              "urn:ietf:params:jmap:websocket": {
                "supportsPush": true,
                "url": "ws://domain.com/jmap/ws"
              },
              "urn:ietf:params:jmap:core": {
                "maxSizeUpload": 20971520,
                "maxConcurrentUpload": 4,
                "maxSizeRequest": 10000000,
                "maxConcurrentRequests": 4,
                "maxCallsInRequest": 16,
                "maxObjectsInGet": 500,
                "maxObjectsInSet": 500,
                "collationAlgorithms": [
                  "i;unicode-casemap"
                ]
              },
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
              "urn:apache:james:params:jmap:mail:quota": {},
              "urn:apache:james:params:jmap:mail:shares": {},
              "urn:ietf:params:jmap:vacationresponse": {},
              "urn:ietf:params:jmap:mdn": {}
            }
          }
        },
        "primaryAccounts": {
          "urn:tmail:custom:params:mailbox": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:submission": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:websocket": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:core": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mail": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:quota": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:apache:james:params:jmap:mail:shares": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:vacationresponse": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mdn": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6"
        },
        "username": "bob@domain.tld",
        "apiUrl": "http://domain.com/jmap",
        "downloadUrl": "http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}",
        "uploadUrl": "http://domain.com/upload/{accountId}",
        "eventSourceUrl": "http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
        "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
      }''';
      final customCapabilityIdentifier = CapabilityIdentifier(Uri.parse('urn:tmail:custom:params:mailbox'));
      final customCapability = DefaultCapability(
          {
            "param1": 1,
            "param2": "good",
            "param3": {"custom", "capability"}.toList()
          }
      );

      final testCapability = TestCapability(100, 'test', {"test", "capability"});

      final Session expectedSession = Session(
          {
            TestCapability.testCapabilityIdentifier: testCapability,
            customCapabilityIdentifier: customCapability,
            CapabilityIdentifier.jmapSubmission: SubmissionCapability(
              maxDelayedSend: UnsignedInt(0),
              submissionExtensions: {}
            ),
            CapabilityIdentifier.jmapCore: CoreCapability(
              maxSizeUpload: UnsignedInt(20971520),
              maxConcurrentUpload: UnsignedInt(4),
              maxSizeRequest: UnsignedInt(10000000),
              maxConcurrentRequests: UnsignedInt(4),
              maxCallsInRequest: UnsignedInt(16),
              maxObjectsInGet: UnsignedInt(500),
              maxObjectsInSet: UnsignedInt(500),
              collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
            ),
            CapabilityIdentifier.jmapMail: MailCapability(
              maxMailboxesPerEmail: UnsignedInt(10000000),
              maxSizeMailboxName: UnsignedInt(200),
              maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
              emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
              mayCreateTopLevelMailbox: true
            ),
            CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
              supportsPush: true,
              url: Uri.parse('ws://domain.com/jmap/ws')
            ),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
            CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
            CapabilityIdentifier.jmapMdn: MdnCapability()
          },
          {
            AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')): Account(
                AccountName('bob@domain.tld'),
                true,
                false,
                {
                  customCapabilityIdentifier: customCapability,
                  CapabilityIdentifier.jmapSubmission: SubmissionCapability(
                    maxDelayedSend: UnsignedInt(0),
                    submissionExtensions: {}
                  ),
                  CapabilityIdentifier.jmapWebSocket: WebSocketCapability(
                    supportsPush: true,
                    url: Uri.parse('ws://domain.com/jmap/ws')
                  ),
                  CapabilityIdentifier.jmapCore: CoreCapability(
                    maxSizeUpload: UnsignedInt(20971520),
                    maxConcurrentUpload: UnsignedInt(4),
                    maxSizeRequest: UnsignedInt(10000000),
                    maxConcurrentRequests: UnsignedInt(4),
                    maxCallsInRequest: UnsignedInt(16),
                    maxObjectsInGet: UnsignedInt(500),
                    maxObjectsInSet: UnsignedInt(500),
                    collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
                  ),
                  CapabilityIdentifier.jmapMail: MailCapability(
                    maxMailboxesPerEmail: UnsignedInt(10000000),
                    maxSizeMailboxName: UnsignedInt(200),
                    maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
                    emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
                    mayCreateTopLevelMailbox: true
                  ),
                  CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): DefaultCapability(Map<String, dynamic>()),
                  CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): DefaultCapability(Map<String, dynamic>()),
                  CapabilityIdentifier.jmapVacationResponse: VacationCapability(),
                  CapabilityIdentifier.jmapMdn: MdnCapability()
                }
            )
          },
          {
            customCapabilityIdentifier: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapSubmission: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapWebSocket: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapCore: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMail: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:quota')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares')): AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapVacationResponse: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMdn: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          },
          UserName('bob@domain.tld'),
          Uri.parse('http://domain.com/jmap'),
          Uri.parse('http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}'),
          Uri.parse('http://domain.com/upload/{accountId}'),
          Uri.parse('http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}'),
          State('2c9f1b12-b35a-43e6-9af2-0106fb53a943')
      );

      final parsedSession = Session.fromJson(
        json.decode(sessionString),
        converter: CapabilitiesConverter()
          ..addConverters({TestCapability.testCapabilityIdentifier: TestCapability.deserialize})
          ..build()
      );

      expect(parsedSession, equals(expectedSession));
      expect(parsedSession.capabilities[TestCapability.testCapabilityIdentifier], equals(testCapability));
    });
  });

  group('get session with empty capability', () {
    test('get should ignore parsing empty capability properties', () {
      final sessionString = '''{
        "capabilities": {
          "urn:ietf:params:jmap:submission": {
            "maxDelayedSend": 0,
            "submissionExtensions": {}
          },
          "urn:ietf:params:jmap:core": {
            "maxSizeUpload": 20971520,
            "maxConcurrentUpload": 4,
            "maxSizeRequest": 10000000,
            "maxConcurrentRequests": 4,
            "maxCallsInRequest": 16,
            "maxObjectsInGet": 500,
            "maxObjectsInSet": 500,
            "collationAlgorithms": [
              "i;unicode-casemap"
            ]
          },
          "urn:ietf:params:jmap:mail": {}
        },
        "accounts": {
          "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6": {
            "name": "bob@domain.tld",
            "isPersonal": true,
            "isReadOnly": false,
            "accountCapabilities": {
              "urn:ietf:params:jmap:submission": {
                "maxDelayedSend": 0,
                "submissionExtensions": {}
              },
              "urn:ietf:params:jmap:core": {
                "maxSizeUpload": 20971520,
                "maxConcurrentUpload": 4,
                "maxSizeRequest": 10000000,
                "maxConcurrentRequests": 4,
                "maxCallsInRequest": 16,
                "maxObjectsInGet": 500,
                "maxObjectsInSet": 500,
                "collationAlgorithms": [
                  "i;unicode-casemap"
                ]
              },
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
              }
            }
          }
        },
        "primaryAccounts": {
          "urn:ietf:params:jmap:submission": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:core": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
          "urn:ietf:params:jmap:mail": "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6"
        },
        "username": "bob@domain.tld",
        "apiUrl": "http://domain.com/jmap",
        "downloadUrl": "http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}",
        "uploadUrl": "http://domain.com/upload/{accountId}",
        "eventSourceUrl": "http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}",
        "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943"
      }''';

      final Session expectedSession = Session(
          {
            CapabilityIdentifier.jmapSubmission: SubmissionCapability(
              maxDelayedSend: UnsignedInt(0),
              submissionExtensions: {}
            ),
            CapabilityIdentifier.jmapCore: CoreCapability(
              maxSizeUpload: UnsignedInt(20971520),
              maxConcurrentUpload: UnsignedInt(4),
              maxSizeRequest: UnsignedInt(10000000),
              maxConcurrentRequests: UnsignedInt(4),
              maxCallsInRequest: UnsignedInt(16),
              maxObjectsInGet: UnsignedInt(500),
              maxObjectsInSet: UnsignedInt(500),
              collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
            ),
            CapabilityIdentifier.jmapMail: MailCapability(),
          },
          {
            AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')): Account(
                AccountName('bob@domain.tld'),
                true,
                false,
                {
                  CapabilityIdentifier.jmapSubmission: SubmissionCapability(
                    maxDelayedSend: UnsignedInt(0),
                    submissionExtensions: {}
                  ),
                  CapabilityIdentifier.jmapCore: CoreCapability(
                    maxSizeUpload: UnsignedInt(20971520),
                    maxConcurrentUpload: UnsignedInt(4),
                    maxSizeRequest: UnsignedInt(10000000),
                    maxConcurrentRequests: UnsignedInt(4),
                    maxCallsInRequest: UnsignedInt(16),
                    maxObjectsInGet: UnsignedInt(500),
                    maxObjectsInSet: UnsignedInt(500),
                    collationAlgorithms: {CollationIdentifier("i;unicode-casemap")}
                  ),
                  CapabilityIdentifier.jmapMail: MailCapability(
                    maxMailboxesPerEmail: UnsignedInt(10000000),
                    maxSizeMailboxName: UnsignedInt(200),
                    maxSizeAttachmentsPerEmail: UnsignedInt(20000000),
                    emailQuerySortOptions: {"receivedAt", "sentAt", "size", "from", "to", "subject"},
                    mayCreateTopLevelMailbox: true
                  ),
                }
            )
          },
          {
            CapabilityIdentifier.jmapSubmission: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapCore: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
            CapabilityIdentifier.jmapMail: AccountId(Id('29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6')),
          },
          UserName('bob@domain.tld'),
          Uri.parse('http://domain.com/jmap'),
          Uri.parse('http://domain.com/download/{accountId}/{blobId}/?type={type}&name={name}'),
          Uri.parse('http://domain.com/upload/{accountId}'),
          Uri.parse('http://domain.com/eventSource?types={types}&closeAfter={closeafter}&ping={ping}'),
          State('2c9f1b12-b35a-43e6-9af2-0106fb53a943')
      );

      final parsedSession = Session.fromJson(json.decode(sessionString));

      expect(parsedSession, equals(expectedSession));
    });
  });
}
