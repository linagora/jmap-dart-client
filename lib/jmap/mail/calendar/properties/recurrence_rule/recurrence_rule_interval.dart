import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';

class RecurrenceRuleInterval with EquatableMixin {

  final UnsignedInt value;

  RecurrenceRuleInterval(this.value);

  @override
  List<Object?> get props => [value];
}