import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blob.g.dart';

@JsonSerializable()
class Blob with EquatableMixin {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? blobId;

  @JsonKey(includeIfNull: false)
  final int? size;

  @JsonKey(includeIfNull: false)
  final String? parentId;

  @JsonKey(includeIfNull: false)
  final List<Map<String, dynamic>>? data;

  const Blob({
    this.blobId,
    this.size,
    this.data,
    this.parentId,
  });

  factory Blob.fromJson(Map<String, dynamic> json) => _$BlobFromJson(json);

  Map<String, dynamic> toJson() => _$BlobToJson(this);

  @override
  List<Object?> get props => [
        blobId,
        size,
        parentId,
        data,
      ];
}
