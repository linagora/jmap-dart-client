import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class Context with EquatableMixin {
  static final private = Context("private");
  static final work = Context("work");

  final String value;

  Context(this.value);

  String toPatchObjectJson() {
    return '${PatchObject.keywordsProperty}/$value';
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'Context(value: $value)';

}
