import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/references_email_submission_id_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission_id.dart';

class SetMethodPropertiesConverter {
  MapEntry<String, dynamic> fromMapIdToJson(Id id, dynamic object) {
    return MapEntry(const IdConverter().toJson(id), object);
  }

  MapEntry<String, dynamic> fromMapEmailSubmissionIdToJson(EmailSubmissionId emailSubmissionId, dynamic object) {
    if (object is PatchObject) {
      return MapEntry(const ReferencesEmailSubmissionIdConverter().toJson(emailSubmissionId), object.toJson());
    } else {
      return MapEntry(const ReferencesEmailSubmissionIdConverter().toJson(emailSubmissionId), object);
    }
  }
}