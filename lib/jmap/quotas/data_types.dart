
import 'package:equatable/equatable.dart';

class DataType with EquatableMixin {
  static final DataType mail = DataType('Mail');
  static final DataType calendar = DataType('Calendar');
  static final DataType contact = DataType('Contact');

  final String value;

  DataType(this.value);

  @override
  List<Object?> get props => [value];
}

enum Scope {
  account,
  domain,
  global
}

enum ResourceType {
  count,
  octets
}
