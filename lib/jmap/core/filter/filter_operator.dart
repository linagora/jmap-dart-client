import 'package:jmap_dart_client/jmap/core/filter/filter.dart';

abstract class FilterOperator extends Filter {

  final Operator operator;
  final Set<Filter> conditions;

  FilterOperator(this.operator, this.conditions);
}

enum Operator {
  AND, OR, NOT
}