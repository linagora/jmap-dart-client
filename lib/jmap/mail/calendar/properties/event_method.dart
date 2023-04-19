
import 'package:json_annotation/json_annotation.dart';

enum EventMethod {
  @JsonValue('PUBLISH')
  publish,
  @JsonValue('REQUEST')
  request,
  @JsonValue('REPLY')
  reply,
  @JsonValue('ADD')
  add,
  @JsonValue('CANCEL')
  cancel,
  @JsonValue('REFRESH')
  refresh,
  @JsonValue('COUNTER')
  counter,
  @JsonValue('DECLINECOUNTER')
  declineCounter;
}