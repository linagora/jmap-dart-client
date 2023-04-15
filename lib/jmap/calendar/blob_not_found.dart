import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../account_id.dart';

part 'blob_not_found.g.dart';

@JsonSerializable()
class BlobNotFound with EquatableMixin {
  final AccountId? accountId;
  final List<String>? notFound;

  BlobNotFound({this.accountId, this.notFound});

  factory BlobNotFound.fromJson(Map<String, dynamic> json) =>
      _$BlobNotFoundFromJson(json);

  Map<String, dynamic> toJson() => _$BlobNotFoundToJson(this);

  @override
  List<Object?> get props => [accountId, notFound];
}
