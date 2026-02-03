import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

@IdNullableConverter()
@JsonSerializable()
class AddressBook with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final Id? id;

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(includeIfNull: false)
  final bool? mayReadItems;

  @JsonKey(includeIfNull: false)
  final bool? mayAddItems;

  @JsonKey(includeIfNull: false)
  final bool? mayModifyItems;

  @JsonKey(includeIfNull: false)
  final bool? mayRemoveItems;

  @JsonKey(includeIfNull: false)
  final bool? mayRename;

  @JsonKey(includeIfNull: false)
  final bool? mayDelete;

  @JsonKey(includeIfNull: false)
  final bool? mayShare;

  @JsonKey(includeIfNull: false)
  final String? role;

  AddressBook({
    this.id,
    this.type,
    this.name,
    this.description,
    this.mayReadItems,
    this.mayAddItems,
    this.mayModifyItems,
    this.mayRemoveItems,
    this.mayRename,
    this.mayDelete,
    this.mayShare,
    this.role,
  });

  factory AddressBook.fromJson(Map<String, dynamic> json) =>
      _$AddressBookFromJson(json);

  Map<String, dynamic> toJson() => _$AddressBookToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        description,
        mayReadItems,
        mayAddItems,
        mayModifyItems,
        mayRemoveItems,
        mayRename,
        mayDelete,
        mayShare,
        role,
      ];
}

AddressBook _$AddressBookFromJson(Map<String, dynamic> json) => AddressBook(
      id: const IdNullableConverter().fromJson(json['id'] as String?),
      type: json['@type'] as String?,
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
  writeNotNull('@type', instance.type);
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
