
import 'package:equatable/equatable.dart';

class CalendarExtensionFields with EquatableMixin {
  final Map<String, List<String>> mapFields;

  CalendarExtensionFields(this.mapFields);

  @override
  List<Object?> get props => [mapFields];
}