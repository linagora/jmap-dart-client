import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar/blob_id.dart';

import 'package:json_annotation/json_annotation.dart';

part 'parse.g.dart';

@JsonSerializable()
class Parsed with EquatableMixin {
  final BlobId? blobId;
  Parsed({this.blobId});

  factory Parsed.fromJson(Map<String, dynamic> json) =>
      _$ParsedFromJson(json);

  Map<String, dynamic> toJson() => _$ParsedToJson(this);

  @override
  List<Object?> get props => [blobId];
}
