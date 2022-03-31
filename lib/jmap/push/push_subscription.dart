
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/push/push_subscription_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/push/encryption_key.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_subscription.g.dart';

@PushSubscriptionIdNullableConverter()
@UTCDateNullableConverter()
@JsonSerializable()
class PushSubscription with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final PushSubscriptionId? id;

  @JsonKey(includeIfNull: false)
  final String? deviceClientId;

  @JsonKey(includeIfNull: false)
  final String? url;

  @JsonKey(includeIfNull: false)
  final EncryptionKey? keys;

  @JsonKey(includeIfNull: false)
  final String? verificationCode;

  @JsonKey(includeIfNull: false)
  final UTCDate? expires;

  @JsonKey(includeIfNull: false)
  final List<String>? types;

  PushSubscription({
    this.id,
    this.deviceClientId,
    this.url,
    this.keys,
    this.verificationCode,
    this.expires,
    this.types,
  });

  factory PushSubscription.fromJson(Map<String, dynamic> json) => _$PushSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$PushSubscriptionToJson(this);

  @override
  List<Object?> get props => [id, deviceClientId, url, keys, verificationCode, expires, types];
}

class PushSubscriptionId with EquatableMixin {
  final Id id;

  PushSubscriptionId(this.id);

  @override
  List<Object?> get props => [id];
}