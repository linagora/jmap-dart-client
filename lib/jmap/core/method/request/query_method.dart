import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/filter/filter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class QueryMethod extends MethodRequiringAccountId
    with OptionalPosition, OptionalAnchorOffset, OptionalCalculateTotal,
        OptionalFilter, OptionalSort, OptionalAnchor, OptionalLimit {

  QueryMethod(AccountId accountId) : super(accountId);
}

mixin OptionalPosition {
  @JsonKey(includeIfNull: false)
  int? position;

  void addPosition(int value) {
    position = value;
  }
}

mixin OptionalAnchorOffset {
  @JsonKey(includeIfNull: false)
  int? anchorOffset;

  void addAnchorOffset(int value) {
    anchorOffset = value;
  }
}

mixin OptionalCalculateTotal {
  @JsonKey(includeIfNull: false)
  bool? calculateTotal;

  void addCalculateTotal(bool value) {
    calculateTotal = value;
  }
}

mixin OptionalFilter {
  @JsonKey(includeIfNull: false)
  Filter? filter;

  void addFilters(Filter value) {
    filter = value;
  }
}

mixin OptionalSort {
  @JsonKey(includeIfNull: false)
  Set<Comparator>? sort;

  void addSorts(Set<Comparator> value) {
    sort ??= <Comparator>{};
    sort?.addAll(value);
  }
}

mixin OptionalAnchor {
  @JsonKey(includeIfNull: false)
  Id? anchor;

  void addAnchor(Id value) {
    anchor = value;
  }
}

mixin OptionalLimit {
  @JsonKey(includeIfNull: false)
  UnsignedInt? limit;

  void addLimit(UnsignedInt value) {
    limit = value;
  }
}