import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blob_found_not_parsable.g.dart';

@JsonSerializable()
class BlobFoundNotParsable with EquatableMixin {
  final AccountId? accountId;
  final List<String>? notParsable;

  BlobFoundNotParsable({this.accountId, this.notParsable});

  factory BlobFoundNotParsable.fromJson(Map<String, dynamic> json) =>
      _$BlobFoundNotParsableFromJson(json);

  Map<String, dynamic> toJson() => _$BlobFoundNotParsableToJson(this);

  @override
  List<Object?> get props => [accountId, notParsable];
}
