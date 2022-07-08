import 'package:jmap_dart_client/jmap/core/filter/filter.dart';
import 'package:jmap_dart_client/jmap/core/filter/filter_operator.dart';

class LogicFilterOperator extends FilterOperator {
  LogicFilterOperator(Operator operator, Set<Filter> conditions)
      : super(operator, conditions);

  @override
  List<Object?> get props => [
    operator,
    conditions,
  ];

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'operator': operator.name,
    'conditions': conditions.map((e) => e.toJson()).toList(),
  };
}
