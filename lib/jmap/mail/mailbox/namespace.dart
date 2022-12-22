
import 'package:equatable/equatable.dart';

class Namespace with EquatableMixin {

  final String value;

  Namespace(this.value);

  @override
  List<Object?> get props => [value];
}