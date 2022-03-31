import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/push/push_subscription.dart';
import 'package:json_annotation/json_annotation.dart';

class PushSubscriptionIdNullableConverter implements JsonConverter<PushSubscriptionId?, String?> {
  const PushSubscriptionIdNullableConverter();

  @override
  PushSubscriptionId? fromJson(String? json) => json != null ? PushSubscriptionId(Id(json)) : null;

  @override
  String? toJson(PushSubscriptionId? object) => object?.id.value;
}