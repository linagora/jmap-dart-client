import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class CalendarEventReplyMethod extends MethodRequiringAccountId
  with OptionalLanguage {
  CalendarEventReplyMethod(
    super.accountId,
    {
      required this.blobIds,
    });

  final List<Id> blobIds;

  @override
  List<Object?> get props => [accountId, blobIds, language];
}

mixin OptionalLanguage {
  @JsonKey(includeIfNull: false)
  String? language;

  void addLanguage(String value) {
    language = value;
  }
}