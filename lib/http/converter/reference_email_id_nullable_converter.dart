
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/reference_id.dart';
import 'package:jmap_dart_client/jmap/core/reference_prefix.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class ReferenceEmailIdNullableConverter implements JsonConverter<EmailId?, String?> {
  const ReferenceEmailIdNullableConverter();

  @override
  EmailId? fromJson(String? json) {
    if (json != null) {
      return EmailId(ReferenceId(ReferencePrefix(json[0]), Id(json.substring(1))));
    } else {
      return null;
    }
  }

  @override
  String? toJson(EmailId? object) => object?.toString();
}