import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';

class VacationId with EquatableMixin {

  final Id id;

  VacationId(this.id);

  factory VacationId.singleton() {
    return VacationId(Id('singleton'));
  }

  @override
  List<Object?> get props => [id];
}