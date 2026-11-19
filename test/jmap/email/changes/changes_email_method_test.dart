import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/email/changes/changes_email_method.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final accountId = AccountId(Id('account-id'));
  final state = State('since-state');

  group('ChangesEmailMethod', () {
    test('forwards maxChanges to the request', () {
      final method = ChangesEmailMethod(accountId, state, maxChanges: UnsignedInt(30));

      expect(method.maxChanges, UnsignedInt(30));
      expect(method.toJson()['maxChanges'], 30);
    });

    test('omits maxChanges when not set', () {
      final method = ChangesEmailMethod(accountId, state);

      expect(method.toJson().containsKey('maxChanges'), isFalse);
    });
  });
}
