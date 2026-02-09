import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_book.g.dart';

@JsonSerializable()
@IdNullableConverter()
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
