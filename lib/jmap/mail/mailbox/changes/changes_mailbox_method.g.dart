// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_mailbox_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesMailboxMethod _$ChangesMailboxMethodFromJson(Map<String, dynamic> json) {
  return ChangesMailboxMethod(
    const AccountIdConverter().fromJson(json['accountId'] as String),
    const StateConverter().fromJson(json['sinceState'] as String),
    maxChanges: const UnsignedIntNullableConverter()
        .fromJson(json['maxChanges'] as int?),
  );
}

Map<String, dynamic> _$ChangesMailboxMethodToJson(
    ChangesMailboxMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
    'sinceState': const StateConverter().toJson(instance.sinceState),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxChanges',
      const UnsignedIntNullableConverter().toJson(instance.maxChanges));
  return val;
}
