import 'package:jmap_dart_client/jmap/core/method/response/parse_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/util/json_parsers.dart';

class ParseEmailResponse extends ParseResponse<Email> {
  ParseEmailResponse(
    super.accountId, {
    super.parsed,
    super.notParsable,
    super.notFound,
  });

  static ParseEmailResponse deserialize(Map<String, dynamic> json) {
    return ParseEmailResponse(
      JsonParsers().parsingAccountId(json),
      parsed: JsonParsers().parsingMapEmail(json, 'parsed'),
      notParsable: JsonParsers().parsingListId(json, 'notParsable'),
      notFound: JsonParsers().parsingListId(json, 'notFound'),
    );
  }

  @override
  List<Object?> get props => [
    accountId,
    parsed,
    notParsable,
    notFound,
  ];
}
