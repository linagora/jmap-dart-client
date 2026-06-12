import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_key.g.dart';

@JsonSerializable()
class CryptoKey with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final String uri;
  final String? mediaType;
  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? pref;
  final String? label;

  CryptoKey({
    this.type = 'CryptoKey',
    required this.uri,
    this.mediaType,
    this.pref,
    this.label,
  });

  factory CryptoKey.fromJson(Map<String, dynamic> json) =>
      _$CryptoKeyFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoKeyToJson(this);

  @override
  List<Object?> get props => [type, uri, mediaType, pref, label];

  @override
  String toString() {
    return 'CryptoKey(type: $type, uri: $uri, mediaType: $mediaType, pref: $pref, label: $label)';
  }
}
