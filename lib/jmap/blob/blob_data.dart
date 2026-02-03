import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blob_data.g.dart';

@JsonSerializable(explicitToJson: true)
class BlobData with EquatableMixin {
  final String id;

  @JsonKey(name: 'data:asText')
  final String? dataAsText;

  @JsonKey(name: 'data:asBase64')
  final String? dataAsBase64;

  @JsonKey(name: 'digest:sha')
  final String? digestSha;

  @JsonKey(name: 'digest:sha-256')
  final String? digestSha256;

  final bool? isEncodingProblem;
  final bool? isTruncated;

  final int size;

  BlobData({
    required this.id,
    required this.size,
    this.dataAsText,
    this.dataAsBase64,
    this.digestSha,
    this.digestSha256,
    this.isEncodingProblem,
    this.isTruncated,
  });

  factory BlobData.fromJson(Map<String, dynamic> json) {
    return BlobData(
      id: json['id'] ?? json['blobId'] ?? "",
      size: json['size'] ?? 0,
      dataAsText: json['data:asText'],
      dataAsBase64: json['data:asBase64'],
      digestSha: json['digest:sha'],
      digestSha256: json['digest:sha-256'],
      isEncodingProblem: json['isEncodingProblem'],
      isTruncated: json['isTruncated'],
    );
  }

  Map<String, dynamic> toJson() => _$BlobDataToJson(this);

  @override
  List<Object?> get props => [
        id,
        size,
        dataAsText,
        dataAsBase64,
        digestSha,
        digestSha256,
        isEncodingProblem,
        isTruncated,
      ];
}
