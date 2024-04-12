import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';

abstract class CalendarEventReplyResponse extends ResponseRequiringAccountId {
  CalendarEventReplyResponse(super.accountId, this.notFound);

  final List<Id>? notFound;

  @override
  List<Object?> get props => [accountId, notFound];
}