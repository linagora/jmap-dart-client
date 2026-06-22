import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/util/email_util.dart';
import 'package:jmap_dart_client/util/mailbox_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Email round-trip tests', () {
    late HttpClient httpClient;
    late AccountId accountId;
    late Id mailboxId;

    setUpAll(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;

      // Create a dedicated test mailbox so emails are isolated
      final setResp = await MailboxUtil.createMailbox(
        client: httpClient,
        accountId: accountId,
        mailbox: Mailbox(name: MailboxName('EmailRoundtripTest')),
      );
      final created = setResp.created?.values.first;
      expect(created, isNotNull, reason: 'Failed to create test mailbox');
      mailboxId = created!.id!.id;
    });

    tearDownAll(() async {
      await MailboxUtil.deleteMailbox(
        client: httpClient,
        accountId: accountId,
        id: mailboxId,
        removeEmails: true,
      );
    });

    test('create, get, update, delete email', () async {
      // Create
      final email = Email(
        mailboxIds: {MailboxId(mailboxId): true},
        subject: 'Round-trip test email',
        from: {EmailAddress('Test Sender', 'sender@example.com')},
        to: {EmailAddress('Test Recipient', 'recipient@example.com')},
        bodyValues: {
          PartId('text1'): EmailBodyValue(
            value: 'Hello from round-trip test',
            isEncodingProblem: false,
            isTruncated: false,
          ),
        },
        keywords: {KeyWordIdentifier.emailDraft: true},
      );

      final createResp = await EmailUtil.createEmail(
        client: httpClient,
        accountId: accountId,
        email: email,
      );

      expect(createResp.created, isNotNull);
      expect(createResp.notCreated, isNull);
      final createdId = createResp.created!.values.first.id!;

      // Get
      final fetched = await EmailUtil.getEmailById(
        client: httpClient,
        accountId: accountId,
        id: createdId.id.value,
      );
      expect(fetched, isNotNull);
      expect(fetched!.subject, equals('Round-trip test email'));
      expect(fetched.mailboxIds, containsPair(MailboxId(mailboxId), true));

      // Update - mark as seen
      final updateResp = await EmailUtil.updateEmail(
        client: httpClient,
        accountId: accountId,
        id: createdId.id,
        patch: PatchObject({'keywords/\$seen': true}),
      );
      expect(updateResp.notUpdated, isNull);

      // Verify update
      final updated = await EmailUtil.getEmailById(
        client: httpClient,
        accountId: accountId,
        id: createdId.id.value,
      );
      expect(updated!.keywords, containsPair(KeyWordIdentifier.emailSeen, true));

      // Delete
      final deleteResp = await EmailUtil.deleteEmail(
        client: httpClient,
        accountId: accountId,
        id: createdId.id,
      );
      expect(deleteResp.destroyed, contains(createdId.id));

      // Verify gone
      final afterDelete = await EmailUtil.getEmailById(
        client: httpClient,
        accountId: accountId,
        id: createdId.id.value,
      );
      expect(afterDelete, isNull);
    });

    test('query emails returns ids', () async {
      await EmailUtil.createEmail(
        client: httpClient,
        accountId: accountId,
        email: Email(
          mailboxIds: {MailboxId(mailboxId): true},
          subject: 'Query test email',
        ),
      );

      final queryResp = await EmailUtil.queryEmails(
        client: httpClient,
        accountId: accountId,
      );

      expect(queryResp.ids, isNotEmpty);
    });

    test('changes returns a valid new state', () async {
      final getResp = await EmailUtil.getEmails(
        client: httpClient,
        accountId: accountId,
      );

      final changesResp = await EmailUtil.changesEmails(
        client: httpClient,
        accountId: accountId,
        sinceState: getResp.state,
      );

      expect(changesResp.newState, isNotNull);
    });
  });
}
