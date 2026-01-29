import 'package:equatable/equatable.dart';

/// Blob object for the JMAP Blob/upload method.

class Blob with EquatableMixin {
  final String? blobId;

  final int? size;

  final String? parentId;


  final List<Map<String, dynamic>>? data;

  Blob({
    this.blobId,
    this.size,
    this.data,
    this.parentId,
  });

  factory Blob.fromJson(Map<String, dynamic> json) {
    return Blob(
      blobId: json['id'],
      size: json['size'],
      parentId: json['parentId'],    
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (data != null) {
      map['data'] = data;
    }

    if (parentId != null) {
      map['parentId'] = parentId;
    }

    return map;
  }

  @override
  List<Object?> get props => [
        blobId,
        size,
        parentId,
        data,
      ];
}
