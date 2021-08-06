import 'package:jmap_dart_client/jmap/core/sort/comparator_property.dart';

class EmailComparatorProperty extends ComparatorProperty {
  static final receivedAt = EmailComparatorProperty('receivedAt');
  static final size = EmailComparatorProperty('size');
  static final from = EmailComparatorProperty('from');
  static final to = EmailComparatorProperty('to');
  static final subject = EmailComparatorProperty('subject');
  static final sentAt = EmailComparatorProperty('sentAt');
  static final hasKeyword = EmailComparatorProperty('hasKeyword');
  static final allInThreadHaveKeyword = EmailComparatorProperty('allInThreadHaveKeyword');
  static final someInThreadHaveKeyword = EmailComparatorProperty('someInThreadHaveKeyword');

  EmailComparatorProperty(String value) : super(value);

  @override
  List<Object> get props => [value];
}
