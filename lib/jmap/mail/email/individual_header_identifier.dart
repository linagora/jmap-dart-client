import 'package:equatable/equatable.dart';

class IndividualHeaderIdentifier with EquatableMixin {
  static final headerUserAgent = IndividualHeaderIdentifier('header:User-Agent:asText');

  final String value;

  IndividualHeaderIdentifier(this.value);

  @override
  List<Object> get props => [value];
}