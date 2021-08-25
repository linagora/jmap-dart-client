import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

class StateNullableConverter implements JsonConverter<State?, String?> {
  const StateNullableConverter();

  @override
  State? fromJson(String? json) => json != null ? State(json) : null;

  @override
  String? toJson(State? object) => object?.value;
}