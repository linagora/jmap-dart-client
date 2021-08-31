import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/reference_prefix.dart';

class ReferenceId extends Id with EquatableMixin {

  final ReferencePrefix prefix;
  final Id id;

  ReferenceId(this.prefix, this.id) : super(id.value);

  @override
  String toString() => '${prefix.value}${id.value}';

  @override
  List<Object?> get props => [prefix, id];
}