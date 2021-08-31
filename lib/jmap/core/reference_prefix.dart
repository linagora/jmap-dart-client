import 'package:equatable/equatable.dart';
import 'package:quiver/check.dart';

class ReferencePrefix with EquatableMixin {

  static final defaultPrefix = ReferencePrefix('#');

  final String value;

  ReferencePrefix(this.value) {
    checkArgument(value.isNotEmpty, message: 'invalid length');
    checkArgument(value.length < 255, message: 'invalid length');
  }

  @override
  List<Object?> get props => [value];
}