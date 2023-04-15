import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../http/converter/parsed_convertre.dart';
import '../../core/method/request/get_response_parsed.dart';
import '../parse.dart';

part 'parse_calender_response.g.dart';

@ParsedConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class ParseCalenderResponse extends GetResponseParsed {
  ParseCalenderResponse(AccountId accountId, Parsed parsed, Parsed? notFound)
      : super(accountId, parsed, notFound);

  factory ParseCalenderResponse.fromJson(Map<String, dynamic> json) =>
      _$ParseCalenderResponseFromJson(json);

  static ParseCalenderResponse deserialize(Map<String, dynamic> json) {
    return ParseCalenderResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$ParseCalenderResponseToJson(this);

  @override
  List<Object?> get props => [accountId, parsed, notFound];
}
