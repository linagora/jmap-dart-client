import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/util/mailbox_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Mailbox round-trip tests', () {
    late HttpClient httpClient;
    late AccountId accountId;

    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test('create, get, update, delete mailbox', () async {
      // Create
      final createResp = await MailboxUtil.createMailbox(
        client: httpClient,
        accountId: accountId,
        mailbox: Mailbox(name: MailboxName('RoundtripTestMailbox')),
      );

      expect(createResp.created, isNotNull);
      expect(createResp.notCreated, isNull);
      final createdMailbox = createResp.created!.values.first;
      final createdId = createdMailbox.id!.id;

      // Get
      final fetched = await MailboxUtil.getMailboxById(
        client: httpClient,
        accountId: accountId,
        id: createdId.value,
      );
      expect(fetched, isNotNull);
      expect(fetched!.name?.name, equals('RoundtripTestMailbox'));

      // Update - rename
      final updateResp = await MailboxUtil.updateMailbox(
        client: httpClient,
        accountId: accountId,
        id: createdId,
        patch: PatchObject({'name': 'RoundtripTestMailbox-Renamed'}),
      );
      expect(updateResp.notUpdated, isNull);

      // Verify rename
      final updated = await MailboxUtil.getMailboxById(
        client: httpClient,
        accountId: accountId,
        id: createdId.value,
      );
      expect(updated!.name?.name, equals('RoundtripTestMailbox-Renamed'));

      // Delete
      final deleteResp = await MailboxUtil.deleteMailbox(
        client: httpClient,
        accountId: accountId,
        id: createdId,
      );
      expect(deleteResp.destroyed, contains(createdId));

      // Verify gone
      final afterDelete = await MailboxUtil.getMailboxById(
        client: httpClient,
        accountId: accountId,
        id: createdId.value,
      );
      expect(afterDelete, isNull);
    });

    test('get all mailboxes returns list', () async {
      final resp = await MailboxUtil.getMailboxes(
        client: httpClient,
        accountId: accountId,
      );
      expect(resp.list, isNotEmpty);
    });

    test('changes returns a valid new state', () async {
      final getResp = await MailboxUtil.getMailboxes(
        client: httpClient,
        accountId: accountId,
      );

      final changesResp = await MailboxUtil.changesMailboxes(
        client: httpClient,
        accountId: accountId,
        sinceState: getResp.state,
      );

      expect(changesResp.newState, isNotNull);
    });

    test('create nested mailbox under parent', () async {
      // Create parent
      final parentResp = await MailboxUtil.createMailbox(
        client: httpClient,
        accountId: accountId,
        mailbox: Mailbox(name: MailboxName('ParentMailbox')),
      );
      final parentId = parentResp.created!.values.first.id!;

      // Create child
      final childResp = await MailboxUtil.createMailbox(
        client: httpClient,
        accountId: accountId,
        mailbox: Mailbox(
          name: MailboxName('ChildMailbox'),
          parentId: parentId,
        ),
      );
      expect(childResp.created, isNotNull);
      final childId = childResp.created!.values.first.id!.id;

      final child = await MailboxUtil.getMailboxById(
        client: httpClient,
        accountId: accountId,
        id: childId.value,
      );
      expect(child!.parentId, equals(parentId));

      // Cleanup
      await MailboxUtil.deleteMailbox(
        client: httpClient,
        accountId: accountId,
        id: childId,
      );
      await MailboxUtil.deleteMailbox(
        client: httpClient,
        accountId: accountId,
        id: parentId.id,
      );
    });
  });
}
