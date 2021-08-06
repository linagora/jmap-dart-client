import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/sort/collation_identifier.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator_property.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class Comparator with EquatableMixin, OptionalIsAscending, OptionalCollation {
  final ComparatorProperty property;

  Comparator(this.property);

  Map<String, dynamic> toJson();
}

mixin OptionalIsAscending {
  @JsonKey(includeIfNull: false)
  bool? isAscending;

  void setIsAscending(bool value) {
    isAscending = value;
  }
}

mixin OptionalCollation {
  @JsonKey(includeIfNull: false)
  CollationIdentifier? collation;

  void addCollation(CollationIdentifier value) {
    collation = value;
  }
}
