import 'package:equatable/equatable.dart';

class ComparatorProperty with EquatableMixin {

  final String value;

  ComparatorProperty(this.value);

  @override
  List<Object?> get props => [value];
}