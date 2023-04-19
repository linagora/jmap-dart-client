
import 'package:equatable/equatable.dart';

class EventId with EquatableMixin {

  final String id;

  EventId(this.id);

  @override
  List<Object?> get props => [id];
}