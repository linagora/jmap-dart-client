import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

class StateConverter implements JsonConverter<State, String> {
  const StateConverter();

  @override
  State fromJson(String json) => State(json);

  @override
  String toJson(State object) => object.value;
}