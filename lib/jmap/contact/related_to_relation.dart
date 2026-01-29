import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class Relation with EquatableMixin {
  static final manager = Relation("manager");
  static final assistant = Relation("assistant");
  static final spouse = Relation("spouse");
  static final friend = Relation("friend");

  final String value;

  Relation(this.value);

  String toPatchObjectJson() {
    return '${PatchObject.keywordsProperty}/$value';
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'Relation(value: $value)';
}
