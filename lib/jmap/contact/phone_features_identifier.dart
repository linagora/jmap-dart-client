import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class PhoneFeature with EquatableMixin {
  static final voice = PhoneFeature("voice");
  static final fax = PhoneFeature("fax");
  static final cell = PhoneFeature("cell");
  static final pager = PhoneFeature("pager");

  final String value;

  PhoneFeature(this.value);

  String toPatchObjectJson() {
    return '${PatchObject.keywordsProperty}/$value';
  }

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'PhoneFeature(value: $value)';
}
