import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';

abstract class ParseResponse<T> extends ResponseRequiringAccountId {
  final Map<Id, T>? parsed;
  final List<Id>? notParsable;
  final List<Id>? notFound;

  ParseResponse(
    AccountId accountId,
    {
      this.parsed,
      this.notParsable,
      this.notFound
    }
  ) : super(accountId);
}