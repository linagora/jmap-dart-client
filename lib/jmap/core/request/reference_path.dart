import 'package:equatable/equatable.dart';

class ReferencePath with EquatableMixin {
  static ReferencePath idsPath = ReferencePath('/ids/*');
  static ReferencePath createdPath = ReferencePath('/created/*');
  static ReferencePath updatedPath = ReferencePath('/updated/*');
  static ReferencePath updatedPropertiesPath = ReferencePath('updatedProperties');

  final String value;

  ReferencePath(this.value);

  @override
  List<Object?> get props => [value];
}