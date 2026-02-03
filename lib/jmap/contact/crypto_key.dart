import 'package:equatable/equatable.dart';

class CryptoKey with EquatableMixin {
  final String uri;
  final String? mediaType;
  final int? pref;
  final String? label;

  CryptoKey({
    required this.uri,
    this.mediaType,
    this.pref,
    this.label,
  });

  factory CryptoKey.fromJson(Map<String, dynamic> json) {
    return CryptoKey(
      uri: json['uri'] as String,
      mediaType: json['mediaType'] as String?,
      pref: json['pref'] as int?,
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('uri', uri);
    writeNotNull('mediaType', mediaType);
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    return map;
  }

  @override
  List<Object?> get props => [uri, mediaType, pref, label];

  @override
  String toString() {
    return 'CryptoKey(uri: $uri, mediaType: $mediaType, pref: $pref, label: $label)';
  }
}
