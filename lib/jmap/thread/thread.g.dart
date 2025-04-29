// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thread _$ThreadFromJson(Map<String, dynamic> json) => Thread(
      id: const ThreadIdConverter().fromJson(json['id'] as String),
      emailIds: (json['emailIds'] as List<dynamic>)
          .map((e) => const EmailIdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$ThreadToJson(Thread instance) => <String, dynamic>{
      'id': const ThreadIdConverter().toJson(instance.id),
      'emailIds':
          instance.emailIds.map(const EmailIdConverter().toJson).toList(),
    };
