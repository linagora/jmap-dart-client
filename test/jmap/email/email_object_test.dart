
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

Map<String, dynamic> _minimalEmailJson({Map<String, dynamic> extra = const {}}) {
  return {
    ...extra,
  };
}

void main() {
  group('email object test', () {
    test('Email.fromJson() should parsing to email object correctly when header:User-Agent:asText is null', () {
      const keywordSeen = '\$seen';
      const emailObjectAsString = '''{
        "to": [
          {
            "name": "Benoît TELLIER",
            "email": "btellier@linagora.com"
          }
        ],
        "receivedAt": "2023-05-29T01:44:51Z",
        "headers": [
          {
            "name": "Return-Path",
            "value": "<dphamhoang@linagora.com>"
          }
        ],
        "attachments": [
          {
            "charset": "us-ascii",
            "disposition": "attachment",
            "size": 75835,
            "partId": "3",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3",
            "name": "DatPH_2023_w21_Remote_Weekly report.ods",
            "type": "application/vnd.oasis.opendocument.spreadsheet"
          }
        ],
        "subject": "[Weekly report] W21 Dat PHAM",
        "size": 1832921,
        "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "preview": "Dear, I update my last week activities. Thanks and BRs",
        "id": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "bodyStructure": {
          "charset": "us-ascii",
          "size": 1831428,
          "partId": "1",
          "type": "multipart/mixed"
        },
        "htmlBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "mailboxIds": {
          "be410040-8269-11eb-acad-a3d8fb60fff0": true
        },
        "bodyValues": {
          "2": {
            "value": "Dear, I update my last week activities. Thanks and BRs",
            "isEncodingProblem": false,
            "isTruncated": false
          }
        },
        "messageId": [
          "112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com"
        ],
        "from": [
          {
            "name": "DatPH",
            "email": "dphamhoang@linagora.com"
          }
        ],
        "keywords": {
          "$keywordSeen": true
        },
        "textBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "cc": [
          {
            "name": "The Dat VU",
            "email": "tdvu@linagora.com"
          },
          {
            "name": "Quang Khai DO",
            "email": "qkdo@linagora.com"
          }
        ],
        "sentAt": "2023-05-29T01:44:28Z",
        "threadId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "hasAttachment": true
      }''';

      final Email expectedEmail = Email(
        id: EmailId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4'),
        threadId: ThreadId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        mailboxIds: {
          MailboxId(Id('be410040-8269-11eb-acad-a3d8fb60fff0')): true
        },
        sentAt: UTCDate(DateTime.parse('2023-05-29T01:44:28Z')),
        receivedAt: UTCDate(DateTime.parse('2023-05-29T01:44:51Z')),
        hasAttachment: true,
        cc: {
          EmailAddress('The Dat VU', 'tdvu@linagora.com'),
          EmailAddress('Quang Khai DO', 'qkdo@linagora.com'),
        },
        from: {
          EmailAddress('DatPH', 'dphamhoang@linagora.com'),
        },
        to: {
          EmailAddress('Benoît TELLIER', 'btellier@linagora.com'),
        },
        messageId: MessageIdsHeaderValue({'112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com'}),
        textBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        htmlBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        keywords: {
          KeyWordIdentifier.emailSeen: true
        },
        bodyValues: {
          PartId('2'): EmailBodyValue(
            value: 'Dear, I update my last week activities. Thanks and BRs',
            isEncodingProblem: false,
            isTruncated: false
          )
        },
        preview: 'Dear, I update my last week activities. Thanks and BRs',
        subject: '[Weekly report] W21 Dat PHAM',
        size: UnsignedInt(1832921),
        attachments: {
          EmailBodyPart(
            charset: 'us-ascii',
            disposition: 'attachment',
            size: UnsignedInt(75835),
            partId: PartId('3'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3'),
            name: 'DatPH_2023_w21_Remote_Weekly report.ods',
            type: MediaType.parse('application/vnd.oasis.opendocument.spreadsheet')
          )
        },
        bodyStructure: EmailBodyPart(
          charset: 'us-ascii',
          size: UnsignedInt(1831428),
          partId: PartId('1'),
          type: MediaType.parse('multipart/mixed')
        ),
        headers: {
          EmailHeader('Return-Path', '<dphamhoang@linagora.com>')
        }
      );

      final parsedEmail = Email.fromJson(jsonDecode(emailObjectAsString));
      log('TEST::main():parsedEmail: $parsedEmail');
      log('TEST::main():expectedEmail: $expectedEmail');
      expect(parsedEmail.id, equals(expectedEmail.id));
    });

    test('Email.fromJson() should parsing to email object correctly when header:User-Agent:asText is not null', () {
      const keywordSeen = '\$seen';
      const emailObjectAsString = '''{
        "to": [
          {
            "name": "Benoît TELLIER",
            "email": "btellier@linagora.com"
          }
        ],
        "header:User-Agent:asText": "Team-Mail/0.7.8 Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
        "receivedAt": "2023-05-29T01:44:51Z",
        "headers": [
          {
            "name": "Return-Path",
            "value": " <dphamhoang@linagora.com>"
          }
        ],
        "attachments": [
          {
            "charset": "us-ascii",
            "disposition": "attachment",
            "size": 75835,
            "partId": "3",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3",
            "name": "DatPH_2023_w21_Remote_Weekly report.ods",
            "type": "application/vnd.oasis.opendocument.spreadsheet"
          }
        ],
        "subject": "[Weekly report] W21 Dat PHAM",
        "size": 1832921,
        "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "preview": "Dear, I update my last week activities. Thanks and BRs",
        "references": null,
        "id": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "bodyStructure": {
          "charset": "us-ascii",
          "size": 1831428,
          "partId": "1",
          "type": "multipart/mixed"
        },
        "htmlBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "mailboxIds": {
          "be410040-8269-11eb-acad-a3d8fb60fff0": true
        },
        "bodyValues": {
          "2": {
            "value": "Dear, I update my last week activities. Thanks and BRs",
            "isEncodingProblem": false,
            "isTruncated": false
          }
        },
        "messageId": [
          "112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com"
        ],
        "from": [
          {
            "name": "DatPH",
            "email": "dphamhoang@linagora.com"
          }
        ],
        "keywords": {
          "$keywordSeen": true
        },
        "textBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "cc": [
          {
            "name": "The Dat VU",
            "email": "tdvu@linagora.com"
          },
          {
            "name": "Quang Khai DO",
            "email": "qkdo@linagora.com"
          }
        ],
        "sentAt": "2023-05-29T01:44:28Z",
        "threadId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "hasAttachment": true
      }''';

      final Email expectedEmail = Email(
        id: EmailId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4'),
        threadId: ThreadId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        mailboxIds: {
          MailboxId(Id('be410040-8269-11eb-acad-a3d8fb60fff0')): true
        },
        sentAt: UTCDate(DateTime.parse('2023-05-29T01:44:28Z')),
        receivedAt: UTCDate(DateTime.parse('2023-05-29T01:44:51Z')),
        hasAttachment: true,
        cc: {
          EmailAddress('The Dat VU', 'tdvu@linagora.com'),
          EmailAddress('Quang Khai DO', 'qkdo@linagora.com'),
        },
        from: {
          EmailAddress('DatPH', 'dphamhoang@linagora.com'),
        },
        to: {
          EmailAddress('Benoît TELLIER', 'btellier@linagora.com'),
        },
        messageId: MessageIdsHeaderValue({'112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com'}),
        textBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        htmlBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        keywords: {
          KeyWordIdentifier.emailSeen: true
        },
        bodyValues: {
          PartId('2'): EmailBodyValue(
            value: 'Dear, I update my last week activities. Thanks and BRs',
            isEncodingProblem: false,
            isTruncated: false
          )
        },
        preview: 'Dear, I update my last week activities. Thanks and BRs',
        subject: '[Weekly report] W21 Dat PHAM',
        size: UnsignedInt(1832921),
        attachments: {
          EmailBodyPart(
            charset: 'us-ascii',
            disposition: 'attachment',
            size: UnsignedInt(75835),
            partId: PartId('3'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3'),
            name: 'DatPH_2023_w21_Remote_Weekly report.ods',
            type: MediaType.parse('application/vnd.oasis.opendocument.spreadsheet')
          )
        },
        bodyStructure: EmailBodyPart(
          charset: 'us-ascii',
          size: UnsignedInt(1831428),
          partId: PartId('1'),
          type: MediaType.parse('multipart/mixed')
        ),
        headers: {
          EmailHeader('Return-Path', ' <dphamhoang@linagora.com>')
        },
        individualHeaders: {IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('Team-Mail/0.7.8 Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36')}
      );

      final parsedEmail = Email.fromJson(jsonDecode(emailObjectAsString));

      expect(parsedEmail.id, equals(expectedEmail.id));
    });

    test('Email.toJson() omits header key when header value toJson() is null', () {
      final email = Email(
        individualHeaders: {
          IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue(null),
        },
      );

      final json = email.toJson();

      expect(json.containsKey('header:User-Agent:asText'), isFalse);
    });

    test('Email with default individualHeaders equals Email with explicit empty map', () {
      final emailDefault = Email(subject: 'test');
      final emailEmpty = Email(subject: 'test', individualHeaders: {});

      expect(emailDefault, equals(emailEmpty));
    });

    test('null-value getter returns non-null TextHeaderValue with null value when key present', () {
      final email = Email(
        individualHeaders: {
          IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue(null),
        },
      );

      final header = email.headerUserAgent;

      expect(header, isNotNull);
      expect(header!.value, isNull);
    });

    group('multiple IndividualHeaderIdentifier', () {
      test('fromJson() parses multiple header:* keys into individualHeaders', () {
        final json = {
          'id': 'abc123',
          'header:User-Agent:asText': 'MyClient/1.0',
          'header:Disposition-Notification-To:asText': 'sender@example.com',
          'header:X-Priority:asText': '1',
          'subject': 'Test',
        };

        final email = Email.fromJson(json);

        expect(email.individualHeaders.length, equals(3));
        expect(
          email.individualHeaders[IndividualHeaderIdentifier.headerUserAgent],
          equals(const TextHeaderValue('MyClient/1.0')),
        );
        expect(
          email.individualHeaders[IndividualHeaderIdentifier.headerMdn],
          equals(const TextHeaderValue('sender@example.com')),
        );
        expect(
          email.individualHeaders[IndividualHeaderIdentifier.xPriorityHeader],
          equals(const TextHeaderValue('1')),
        );
      });

      test('fromJson() does not include non-header email fields in individualHeaders', () {
        final json = {
          'id': 'abc123',
          'subject': 'Hello',
          'header:User-Agent:asText': 'MyClient/1.0',
        };

        final email = Email.fromJson(json);

        expect(email.individualHeaders.length, equals(1));
        expect(email.individualHeaders.keys.first.value, equals('header:User-Agent:asText'));
      });

      test('fromJson() parses header:*:asAddresses into AddressesHeaderValue', () {
        final json = {
          'header:From:asAddresses': [
            {'name': 'Alice', 'email': 'alice@example.com'},
          ],
        };

        final email = Email.fromJson(json);

        final value = email.individualHeaders[IndividualHeaderIdentifier.asAddresses('From')];
        expect(value, isA<AddressesHeaderValue>());
        expect((value as AddressesHeaderValue).addresses.length, equals(1));
        expect(value.addresses[0], equals(EmailAddress('Alice', 'alice@example.com')));
      });

      test('fromJson() parses header:*:asMessageIds into MessageIdsEmailHeaderValue', () {
        final json = {
          'header:Message-ID:asMessageIds': ['msg1@host.com', 'msg2@host.com'],
        };

        final email = Email.fromJson(json);

        final value = email.individualHeaders[IndividualHeaderIdentifier.asMessageIds('Message-ID')];
        expect(value, isA<MessageIdsEmailHeaderValue>());
        expect((value as MessageIdsEmailHeaderValue).ids, equals(['msg1@host.com', 'msg2@host.com']));
      });

      test('fromJson() parses header:*:asURLs into URLsHeaderValue', () {
        final json = {
          'header:List-Unsubscribe:asURLs': ['https://example.com/unsub'],
        };

        final email = Email.fromJson(json);

        final value = email.individualHeaders[IndividualHeaderIdentifier.asURLs('List-Unsubscribe')];
        expect(value, isA<URLsHeaderValue>());
        expect((value as URLsHeaderValue).urls, equals(['https://example.com/unsub']));
      });

      test('fromJson() parses header:*:asRaw:all into AllHeaderValue of RawHeaderValues', () {
        final json = {
          'header:Received:asRaw:all': [' from a.example.com', ' from b.example.com'],
        };

        final email = Email.fromJson(json);

        final key = IndividualHeaderIdentifier.asRaw('Received').all();
        final value = email.individualHeaders[key];
        expect(value, isA<AllHeaderValue>());
        final all = (value as AllHeaderValue).values;
        expect(all.length, equals(2));
        expect(all[0], isA<RawHeaderValue>());
        expect((all[0] as RawHeaderValue).value, equals(' from a.example.com'));
      });

      test('fromJson() parses explicitly null header value to TextHeaderValue(null)', () {
        final json = {
          'header:User-Agent:asText': null,
        };

        final email = Email.fromJson(json);

        final value = email.individualHeaders[IndividualHeaderIdentifier.headerUserAgent];
        expect(value, isA<TextHeaderValue>());
        expect((value as TextHeaderValue).value, isNull);
      });

      test('toJson() serializes multiple individual headers, omits null-value entries', () {
        final email = Email(
          subject: 'Test',
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('MyClient/1.0'),
            IndividualHeaderIdentifier.xPriorityHeader: const TextHeaderValue('1'),
            IndividualHeaderIdentifier.headerMdn: const TextHeaderValue(null),
          },
        );

        final json = email.toJson();

        expect(json['header:User-Agent:asText'], equals('MyClient/1.0'));
        expect(json['header:X-Priority:asText'], equals('1'));
        expect(json.containsKey('header:Disposition-Notification-To:asText'), isFalse);
      });

      test('backward-compat getter returns null when key absent', () {
        final email = Email(subject: 'test');

        expect(email.headerUserAgent, isNull);
        expect(email.headerMdn, isNull);
        expect(email.xPriorityHeader, isNull);
        expect(email.importanceHeader, isNull);
        expect(email.priorityHeader, isNull);
        expect(email.listPostHeader, isNull);
        expect(email.listUnsubscribeHeader, isNull);
      });

      test('backward-compat getter returns null when stored value is not TextHeaderValue', () {
        final email = Email(
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const RawHeaderValue('MyClient/1.0'),
          },
        );

        expect(email.headerUserAgent, isNull);
      });

      test('two Emails with same individualHeaders map are equal', () {
        final email1 = Email(
          subject: 'Hello',
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('A'),
            IndividualHeaderIdentifier.xPriorityHeader: const TextHeaderValue('1'),
          },
        );
        final email2 = Email(
          subject: 'Hello',
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('A'),
            IndividualHeaderIdentifier.xPriorityHeader: const TextHeaderValue('1'),
          },
        );

        expect(email1, equals(email2));
      });

      test('two Emails with different individualHeaders are not equal', () {
        final email1 = Email(
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('A'),
          },
        );
        final email2 = Email(
          individualHeaders: {
            IndividualHeaderIdentifier.headerUserAgent: const TextHeaderValue('B'),
          },
        );

        expect(email1, isNot(equals(email2)));
      });
    });

    test('Email.toJson() should convert to json correctly', () {
      const keywordSeen = '\$seen';
      const expectedEmailAsJson = '''{
        "to": [
          {
            "name": "Benoît TELLIER",
            "email": "btellier@linagora.com"
          }
        ],
        "receivedAt": "2023-05-29T01:44:51.000Z",
        "headers": [
          {
            "name": "Return-Path",
            "value": " <dphamhoang@linagora.com>"
          }
        ],
        "attachments": [
          {
            "charset": "us-ascii",
            "disposition": "attachment",
            "size": 75835,
            "partId": "3",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3",
            "name": "DatPH_2023_w21_Remote_Weekly report.ods",
            "type": "application/vnd.oasis.opendocument.spreadsheet"
          }
        ],
        "subject": "[Weekly report] W21 Dat PHAM",
        "size": 1832921,
        "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "preview": "Dear, I update my last week activities. Thanks and BRs",
        "id": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "bodyStructure": {
          "charset": "us-ascii",
          "size": 1831428,
          "partId": "1",
          "type": "multipart/mixed"
        },
        "htmlBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "mailboxIds": {
          "be410040-8269-11eb-acad-a3d8fb60fff0": true
        },
        "bodyValues": {
          "2": {
            "value": "Dear, I update my last week activities. Thanks and BRs",
            "isEncodingProblem": false,
            "isTruncated": false
          }
        },
        "messageId": [
          "112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com"
        ],
        "from": [
          {
            "name": "DatPH",
            "email": "dphamhoang@linagora.com"
          }
        ],
        "keywords": {
          "$keywordSeen": true
        },
        "textBody": [
          {
            "charset": "us-ascii",
            "size": 64,
            "partId": "2",
            "blobId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2",
            "type": "text/plain"
          }
        ],
        "cc": [
          {
            "name": "The Dat VU",
            "email": "tdvu@linagora.com"
          },
          {
            "name": "Quang Khai DO",
            "email": "qkdo@linagora.com"
          }
        ],
        "sentAt": "2023-05-29T01:44:28.000Z",
        "threadId": "6722f3a0-fdc2-11ed-9e42-3f61c2e789b4",
        "hasAttachment": true
      }''';

      final Email email = Email(
        id: EmailId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4'),
        threadId: ThreadId(Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4')),
        mailboxIds: {
          MailboxId(Id('be410040-8269-11eb-acad-a3d8fb60fff0')): true
        },
        sentAt: UTCDate(DateTime.parse('2023-05-29T01:44:28.000Z')),
        receivedAt: UTCDate(DateTime.parse('2023-05-29T01:44:51.000Z')),
        hasAttachment: true,
        cc: {
          EmailAddress('The Dat VU', 'tdvu@linagora.com'),
          EmailAddress('Quang Khai DO', 'qkdo@linagora.com'),
        },
        from: {
          EmailAddress('DatPH', 'dphamhoang@linagora.com'),
        },
        to: {
          EmailAddress('Benoît TELLIER', 'btellier@linagora.com'),
        },
        messageId: MessageIdsHeaderValue({'112E9ACB-17D3-4E9F-8BFA-7C4A93B2E983@linagora.com'}),
        textBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        htmlBody: {
          EmailBodyPart(
            charset: 'us-ascii',
            size: UnsignedInt(64),
            partId: PartId('2'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_2'),
            type: MediaType.parse('text/plain')
          )
        },
        keywords: {
          KeyWordIdentifier.emailSeen: true
        },
        bodyValues: {
          PartId('2'): EmailBodyValue(
            value: 'Dear, I update my last week activities. Thanks and BRs',
            isEncodingProblem: false,
            isTruncated: false
          )
        },
        preview: 'Dear, I update my last week activities. Thanks and BRs',
        subject: '[Weekly report] W21 Dat PHAM',
        size: UnsignedInt(1832921),
        attachments: {
          EmailBodyPart(
            charset: 'us-ascii',
            disposition: 'attachment',
            size: UnsignedInt(75835),
            partId: PartId('3'),
            blobId: Id('6722f3a0-fdc2-11ed-9e42-3f61c2e789b4_3'),
            name: 'DatPH_2023_w21_Remote_Weekly report.ods',
            type: MediaType.parse('application/vnd.oasis.opendocument.spreadsheet')
          )
        },
        bodyStructure: EmailBodyPart(
          charset: 'us-ascii',
          size: UnsignedInt(1831428),
          partId: PartId('1'),
          type: MediaType.parse('multipart/mixed')
        ),
        headers: {
          EmailHeader('Return-Path', ' <dphamhoang@linagora.com>')
        }
      );

      final emailJson = email.toJson();

      expect(emailJson, equals(jsonDecode(expectedEmailAsJson)));
    });
  });

  group('Email.fromJson headers resilience', () {
    test('one bad headers entry is skipped, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'headers': [
          {'name': 'Subject', 'value': 'Hello'},
          {'name': 123, 'value': 'bad'}, // int name → throws
        ],
      });

      final email = Email.fromJson(json);

      expect(email.headers, isNotNull);
      expect(email.headers!.length, equals(1));
      expect(email.headers!.first.name, equals('Subject'));
    });

    test('all headers entries bad → empty set, no throw', () {
      final json = _minimalEmailJson(extra: {
        'headers': [
          {'name': 123, 'value': 456},
          'not-a-map',
        ],
      });

      expect(() => Email.fromJson(json), returnsNormally);
      final email = Email.fromJson(json);
      expect(email.headers, isEmpty);
    });

    test('null headers field → headers is null', () {
      final email = Email.fromJson(_minimalEmailJson());
      expect(email.headers, isNull);
    });
  });

  group('Email.fromJson bodyValues resilience', () {
    test('one bad bodyValues entry skipped, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'bodyValues': {
          '1': {
            'value': 'Good body',
            'isEncodingProblem': false,
            'isTruncated': false,
          },
          '2': 'not-a-map', // wrong type → throws
        },
      });

      final email = Email.fromJson(json);

      expect(email.bodyValues, isNotNull);
      expect(email.bodyValues!.length, equals(1));
    });

    test('all bodyValues bad → bodyValues is null', () {
      final json = _minimalEmailJson(extra: {
        'bodyValues': {
          '1': 'bad',
          '2': 42,
        },
      });

      final email = Email.fromJson(json);
      expect(email.bodyValues, isNull);
    });

    test('null bodyValues field → bodyValues is null', () {
      final email = Email.fromJson(_minimalEmailJson());
      expect(email.bodyValues, isNull);
    });
  });

  group('Email.fromJson individualHeaders resilience', () {
    test('malformed entry falls back to RawHeaderValue, valid entries preserved', () {
      final json = _minimalEmailJson(extra: {
        'header:Subject:asText': 'My Subject',
        'header:Date:asDate': 99, // int instead of String → throws → RawHeaderValue('99')
      });

      final email = Email.fromJson(json);

      expect(email.individualHeaders.length, equals(2));
      expect(
        email.individualHeaders[IndividualHeaderIdentifier.asText('Subject')],
        equals(const TextHeaderValue('My Subject')),
      );
      expect(
        email.individualHeaders[IndividualHeaderIdentifier.asDate('Date')],
        equals(const RawHeaderValue('99')),
      );
    });

    test('all individualHeaders malformed → all become RawHeaderValue, rest of Email parses', () {
      final json = _minimalEmailJson(extra: {
        'subject': 'Test',
        'header:Subject:asText': 42,  // int → RawHeaderValue('42')
        'header:Date:asDate': true,   // bool → RawHeaderValue('true')
      });

      final email = Email.fromJson(json);

      expect(email.subject, equals('Test'));
      expect(email.individualHeaders.length, equals(2));
      expect(
        email.individualHeaders[IndividualHeaderIdentifier.asText('Subject')],
        equals(const RawHeaderValue('42')),
      );
      expect(
        email.individualHeaders[IndividualHeaderIdentifier.asDate('Date')],
        equals(const RawHeaderValue('true')),
      );
    });

    test('no header: keys → empty individualHeaders', () {
      final json = _minimalEmailJson(extra: {'subject': 'Clean'});
      final email = Email.fromJson(json);
      expect(email.individualHeaders, isEmpty);
    });
  });

  group('Email.toJson individualHeaders resilience', () {
    test('null-value headers are omitted from output', () {
      final email = Email(
        individualHeaders: {
          IndividualHeaderIdentifier.asText('Subject'): const TextHeaderValue('Hello'),
          IndividualHeaderIdentifier.asText('X-Null'): const TextHeaderValue(null),
        },
      );

      final result = email.toJson();

      expect(result.containsKey('header:Subject:asText'), isTrue);
      expect(result['header:Subject:asText'], equals('Hello'));
      expect(result.containsKey('header:X-Null:asText'), isFalse);
    });
  });
}