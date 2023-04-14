import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/email_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response_parsed.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:jmap_dart_client/jmap/core/extensions/utc_date_extension.dart';
import 'package:jmap_dart_client/jmap/core/extensions/string_extension.dart';
import 'package:jmap_dart_client/jmap/core/extensions/unsigned_int_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../http/converter/parsed_convertre.dart';
import '../calender_event.dart';
import '../parse.dart';
import '../parsed_respond.dart';

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
