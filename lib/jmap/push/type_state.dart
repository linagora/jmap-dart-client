
import 'package:equatable/equatable.dart';

class TypeState with EquatableMixin {

  final Map<String, dynamic> typeState;

  TypeState(this.typeState);

  @override
  List<Object?> get props => [typeState];
}