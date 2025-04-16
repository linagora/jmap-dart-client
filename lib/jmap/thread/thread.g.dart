// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      id: const ThreadIdNullableConverter().fromJson(json['id'] as String?),
      emailIds: (json['emailIds'] as List<dynamic>?)
          ?.map((e) => const EmailIdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const ThreadIdNullableConverter().toJson(instance.id));
  writeNotNull('emailIds',
      instance.emailIds?.map(const EmailIdConverter().toJson).toList());
  return val;
}
