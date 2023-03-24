// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disposition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disposition _$DispositionFromJson(Map<String, dynamic> json) => Disposition(
      $enumDecode(_$ActionModeEnumMap, json['actionMode']),
      $enumDecode(_$SendingModeEnumMap, json['sendingMode']),
      $enumDecode(_$DispositionTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$DispositionToJson(Disposition instance) =>
    <String, dynamic>{
      'actionMode': _$ActionModeEnumMap[instance.actionMode]!,
      'sendingMode': _$SendingModeEnumMap[instance.sendingMode]!,
      'type': _$DispositionTypeEnumMap[instance.type]!,
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
