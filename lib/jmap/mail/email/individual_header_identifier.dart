import 'package:equatable/equatable.dart';

class IndividualHeaderIdentifier with EquatableMixin {
  static final headerUserAgent = IndividualHeaderIdentifier('header:User-Agent:asText');
  static final headerMdn = IndividualHeaderIdentifier('header:Disposition-Notification-To:asText');

  final String value;

  IndividualHeaderIdentifier(this.value);

  @override
  List<Object> get props => [value];
}