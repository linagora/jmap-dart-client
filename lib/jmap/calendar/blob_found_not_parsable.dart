import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blob_found_not_parsable.g.dart';

@JsonSerializable()
class BlobFoundNotParsable with EquatableMixin {
  final String? accountId;
  final List<String>? notParsable;

  BlobFoundNotParsable({this.accountId, this.notParsable});

  factory BlobFoundNotParsable.fromJson(Map<String, dynamic> json) =>
      _$BlobFoundNotParsableFromJson(json);

  Map<String, dynamic> toJson() => _$BlobFoundNotParsableToJson(this);

  @override
  List<Object?> get props => [accountId, notParsable];
}
