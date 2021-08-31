
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/reference_id.dart';
import 'package:jmap_dart_client/jmap/core/reference_prefix.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission_id.dart';
import 'package:json_annotation/json_annotation.dart';

class ReferencesEmailSubmissionIdConverter implements JsonConverter<EmailSubmissionId, String> {
  const ReferencesEmailSubmissionIdConverter();

  @override
  EmailSubmissionId fromJson(String json) {
    return EmailSubmissionId(ReferenceId(ReferencePrefix.defaultPrefix, Id(json.substring(1))));
  }

  @override
  String toJson(EmailSubmissionId object) {
    return object.toString();
  }
}