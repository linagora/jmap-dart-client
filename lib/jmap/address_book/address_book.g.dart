// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressBook _$AddressBookFromJson(Map<String, dynamic> json) => AddressBook(
      id: const IdNullableConverter().fromJson(json['id'] as String?),
      type: json['type'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      mayReadItems: json['mayReadItems'] as bool?,
      mayAddItems: json['mayAddItems'] as bool?,
      mayModifyItems: json['mayModifyItems'] as bool?,
      mayRemoveItems: json['mayRemoveItems'] as bool?,
      mayRename: json['mayRename'] as bool?,
      mayDelete: json['mayDelete'] as bool?,
      mayShare: json['mayShare'] as bool?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AddressBookToJson(AddressBook instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const IdNullableConverter().toJson(instance.id));
  writeNotNull('type', instance.type);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('mayReadItems', instance.mayReadItems);
  writeNotNull('mayAddItems', instance.mayAddItems);
  writeNotNull('mayModifyItems', instance.mayModifyItems);
  writeNotNull('mayRemoveItems', instance.mayRemoveItems);
  writeNotNull('mayRename', instance.mayRename);
  writeNotNull('mayDelete', instance.mayDelete);
  writeNotNull('mayShare', instance.mayShare);
  writeNotNull('role', instance.role);
  return val;
}
