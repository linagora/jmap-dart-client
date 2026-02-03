import 'package:equatable/equatable.dart';
import 'package:quiver/check.dart';

class Id with EquatableMixin {
  final String value;
  //final RegExp _idCharacterConstraint = RegExp(r'^[a-zA-Z0-9]+[a-zA-Z0-9-_]*$');

  Id(this.value) {
    checkArgument(value.isNotEmpty, message: 'invalid length');
    checkArgument(value.length < 255, message: 'invalid length');
    //checkArgument(_idCharacterConstraint.hasMatch(value));
    /// Our servers have cases where IDs may start with different characters,
    /// so we are commenting out this constraint for now.
  }

  @override
  List<Object?> get props => [value];
}
