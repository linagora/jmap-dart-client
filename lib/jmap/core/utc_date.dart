import 'package:equatable/equatable.dart';

class UTCDate with EquatableMixin {
  final DateTime value;

  UTCDate(this.value);

  @override
  List<Object?> get props => [value];
}