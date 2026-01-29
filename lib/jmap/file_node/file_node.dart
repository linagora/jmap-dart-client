import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/file_node/files_rights.dart';

class FileNode with EquatableMixin {
  final Id? id;
  final String? name;
  final int? size;
  final Id? parentId;
  final String? blobId;
  final String? created;
  final String? modified;

  /// When the node was last accessed 
  final String? accessed;

  /// UNIX-style exec flag
  final bool? executable;

  /// Server-set ACLs
  final FilesRights? myRights;

  /// Optional sharing map
  final Map<String, FilesRights>? shareWith;

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


  factory FileNode.fromJson(Map<String, dynamic> json) {
    return FileNode(
      id: json['id'] != null ? Id(json['id'].toString()) : null,
      name: json['name'] as String?,
      size: json['size'] is int ? json['size'] : (json['size'] as num?)?.toInt(),
      parentId: json['parentId'] != null ? Id(json['parentId'].toString()) : null,
      blobId: json['blobId'] != null ?(json['blobId'].toString()) : null,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      accessed: json['accessed'] as String?,
      executable: json['executable'] as bool?, 
      myRights: json['myRights'] != null
          ? FilesRights.fromJson(json['myRights'])
          : null,
      shareWith: json['shareWith'] != null
          ? (json['shareWith'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, FilesRights.fromJson(value)))
          : null,
      type: json['type'] as String?
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('id', id?.value);
    writeNotNull('name', name);
    writeNotNull('size', size);
    writeNotNull('parentId', parentId?.value);
    writeNotNull('blobId', blobId);
    writeNotNull('created', created);
    writeNotNull('modified', modified);
    writeNotNull('accessed', accessed);
    writeNotNull('executable', executable);
    writeNotNull('myRights', myRights?.toJson());
    writeNotNull('shareWith',
        shareWith?.map((key, value) => MapEntry(key, value.toJson())));
    writeNotNull('type', type);

    return val;
  }

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
        type
      ];
}


