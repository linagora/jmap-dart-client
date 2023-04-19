
import 'package:equatable/equatable.dart';

class MailAddress with EquatableMixin {

  final String value;

  MailAddress(this.value);

  @override
  List<Object?> get props => [value];
}