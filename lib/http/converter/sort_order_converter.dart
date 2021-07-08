import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class SortOrderConverter implements JsonConverter<SortOrder?, int?> {
  const SortOrderConverter();

  @override
  SortOrder? fromJson(int? json) {
    return json != null ? SortOrder(sortValue: json) : null;
  }

  @override
  int? toJson(SortOrder? object) {
    return object?.value.value.toInt();
  }
}