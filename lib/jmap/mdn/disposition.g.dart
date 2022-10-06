// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disposition _$DispositionFromJson(Map<String, dynamic> json) => Disposition(
      actionMode: $enumDecode(_$ActionModeEnumMap, json['actionMode']),
      sendingMode: $enumDecode(_$SendingModeEnumMap, json['sendingMode']),
      type: $enumDecode(_$DispositionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$DispositionToJson(Disposition instance) =>
    <String, dynamic>{
      'actionMode': instance.actionMode.value,
      'sendingMode': instance.sendingMode.value,
      'type': instance.type.name,
    };

const _$ActionModeEnumMap = {
  ActionMode.manual: 'manual-action',
  ActionMode.automatic: 'automatic-action',
};

const _$SendingModeEnumMap = {
  SendingMode.manually: 'mdn-sent-manually',
  SendingMode.automatically: 'mdn-sent-automatically',
};

const _$DispositionTypeEnumMap = {
  DispositionType.deleted: 'deleted',
  DispositionType.dispatched: 'dispatched',
  DispositionType.displayed: 'displayed',
  DispositionType.processed: 'processed',
};
