import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar.g.dart';

@IdNullableConverter()
@JsonSerializable()
class Calendar with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final Id? id;

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(includeIfNull: false)
  final String? color;

  @JsonKey(includeIfNull: false)
  final bool? isVisible;

  @JsonKey(includeIfNull: false)
  final bool? mayReadFreeBusy;

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

  Calendar({
    this.id,
    this.type,
    this.name,
    this.description,
    this.color,
    this.isVisible,
    this.mayReadFreeBusy,
    this.mayReadItems,
    this.mayAddItems,
    this.mayModifyItems,
    this.mayRemoveItems,
    this.mayRename,
    this.mayDelete,
    this.mayShare,
    this.role,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarToJson(this);

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        description,
        color,
        isVisible,
        mayReadFreeBusy,
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
