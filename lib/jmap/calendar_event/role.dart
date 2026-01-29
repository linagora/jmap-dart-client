import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class Role with EquatableMixin {
  static final private = Role("attendee");
  static final work = Role("owner");

  final String value;

  Role(this.value);

  String toPatchObjectJson() {
    return '${PatchObject.keywordsProperty}/$value';
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'Role(value: $value)';
}
