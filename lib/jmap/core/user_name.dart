import 'package:equatable/equatable.dart';

class UserName with EquatableMixin {
  final String value;

  UserName(this.value);

  @override
  List<Object?> get props => [value];
}