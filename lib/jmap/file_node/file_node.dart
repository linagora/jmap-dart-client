import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/file_node/files_rights_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/file_node/files_rights.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';

part 'file_node.g.dart';

@JsonSerializable()
class FileNode with EquatableMixin {
  @IdConverter()
  @JsonKey(includeIfNull: false)
  final Id? id;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final int? size;

  @IdConverter()
  @JsonKey(includeIfNull: false)
  final Id? parentId;

  @JsonKey(includeIfNull: false)
  final String? blobId;

  @JsonKey(includeIfNull: false)
  final String? created;

  @JsonKey(includeIfNull: false)
  final String? modified;

  /// When the node was last accessed 
  @JsonKey(includeIfNull: false)
  final String? accessed;

  /// UNIX-style exec flag
  @JsonKey(includeIfNull: false)
  final bool? executable;

  /// Server-set ACLs
  @JsonKey(includeIfNull: false)
  final FilesRights? myRights;

  /// Optional sharing map
  @FilesRightsMapConverter()
  @JsonKey(includeIfNull: false)
  final Map<String, FilesRights>? shareWith;

  @JsonKey(includeIfNull: false)
  final String? type;

  FileNode({
    this.id,
    this.name,
    this.size,
    this.parentId,
    this.blobId,
    this.created,
    this.modified,
    this.accessed,
    this.executable,
    this.myRights,
    this.shareWith,
    this.type,
  });

  factory FileNode.fromJson(Map<String, dynamic> json) =>
      _$FileNodeFromJson(json);

  Map<String, dynamic> toJson() => _$FileNodeToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        size,
        parentId,
        blobId,
        created,
        modified,
        accessed,
        executable,
        myRights,
        shareWith,
        type,
      ];
}
