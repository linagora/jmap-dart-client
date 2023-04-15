import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';

import '../../../calendar/parse.dart';

abstract class GetResponseParsed extends ResponseRequiringAccountId {
  final Parsed parsed;
  final Parsed? notFound;
  GetResponseParsed(
    AccountId accountId,
    this.parsed,
    this.notFound,
  ) : super(accountId);
}

abstract class GetResponseNoAccountId<T> extends MethodResponse {
  final Parsed parsed;
  final Parsed? notFound;

  GetResponseNoAccountId(AccountId accountId, this.parsed, this.notFound);
}
