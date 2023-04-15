// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_comparator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailComparator _$EmailComparatorFromJson(Map<String, dynamic> json) =>
    EmailComparator(
      const EmailComparatorPropertyConverter()
          .fromJson(json['property'] as String),
    )
      ..isAscending = json['isAscending'] as bool?
      ..collation = const CollationIdentifierNullableConverter()
          .fromJson(json['collation'] as String?);

Map<String, dynamic> _$EmailComparatorToJson(EmailComparator instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isAscending', instance.isAscending);
  writeNotNull('collation',
      const CollationIdentifierNullableConverter().toJson(instance.collation));
  val['property'] =
      const ComparatorPropertyConverter().toJson(instance.property);
  return val;
}
