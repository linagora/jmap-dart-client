
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
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

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
        headerUserAgent: {IndividualHeaderIdentifier.headerUserAgent: 'Team-Mail/0.7.8 Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36'}
      );

      final parsedEmail = Email.fromJson(jsonDecode(emailObjectAsString));

      expect(parsedEmail.id, equals(expectedEmail.id));
    });

    test('Email.fromJson() should parse additionalHeaders with String value', () {
      const json = '''{
        "id": "abc123",
        "header:X-Custom-Header:asText": "custom-value"
      }''';

      final email = Email.fromJson(jsonDecode(json));
      final key = IndividualHeaderIdentifier('header:X-Custom-Header:asText');

      expect(email.additionalHeaders, isNotNull);
      expect(email.additionalHeaders![key], equals('custom-value'));
    });

    test('Email.fromJson() should parse additionalHeaders with List<String> value', () {
      const json = '''{
        "id": "abc123",
        "header:X-LinkedFile:all:asText": ["file1.pdf", "file2.pdf"]
      }''';

      final email = Email.fromJson(jsonDecode(json));
      final key = IndividualHeaderIdentifier('header:X-LinkedFile:all:asText');

      expect(email.additionalHeaders, isNotNull);
      expect(email.additionalHeaders![key], equals(['file1.pdf', 'file2.pdf']));
    });

    test('Email.fromJson() should not include known headers in additionalHeaders', () {
      const json = '''{
        "id": "abc123",
        "header:User-Agent:asText": "SomeClient/1.0",
        "header:X-Custom-Header:asText": "custom-value"
      }''';

      final email = Email.fromJson(jsonDecode(json));

      expect(email.headerUserAgent, isNotNull);
      expect(email.additionalHeaders?.containsKey(IndividualHeaderIdentifier.headerUserAgent), isNot(true));
      expect(email.additionalHeaders?[IndividualHeaderIdentifier('header:X-Custom-Header:asText')], equals('custom-value'));
    });

    test('Email.toJson() should serialize additionalHeaders with String value', () {
      final key = IndividualHeaderIdentifier('header:X-Custom-Header:asText');
      final email = Email(
        additionalHeaders: {key: 'custom-value'},
      );

      final result = email.toJson();
      expect(result['header:X-Custom-Header:asText'], equals('custom-value'));
    });

    test('Email.toJson() should serialize additionalHeaders with List<String> value', () {
      final key = IndividualHeaderIdentifier('header:X-LinkedFile:all:asText');
      final email = Email(
        additionalHeaders: {key: ['file1.pdf', 'file2.pdf']},
      );

      final result = email.toJson();
      expect(result['header:X-LinkedFile:all:asText'], equals(['file1.pdf', 'file2.pdf']));
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
}