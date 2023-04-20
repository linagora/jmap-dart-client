import 'package:equatable/equatable.dart';

///
/// This format displays a duration in the following format: PnYnMnDTnHnMnS where n is the number for the corresponding interval:
/// Y = years
/// M = months
/// W = weeks
/// D = days
/// T = delimiter between dates and times, necessary to disambiguate between months and minutes
/// H = hours
/// M = minutes
/// S = seconds
///
class CalendarDuration with EquatableMixin {
  final String value;

  CalendarDuration(this.value);

  @override
  List<Object?> get props => [value];
}