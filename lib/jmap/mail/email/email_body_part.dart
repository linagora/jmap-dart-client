import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/media_type_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/part_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_header.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_body_part.g.dart';

@MediaTypeNullableConverter()
@PartIdNullableConverter()
@UnsignedIntNullableConverter()
@IdNullableConverter()
@JsonSerializable()
class EmailBodyPart with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final PartId? partId;

  @JsonKey(includeIfNull: false)
  final Id? blobId;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? size;

  @JsonKey(includeIfNull: false)
  final Set<EmailHeader>? headers;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final MediaType? type;

  @JsonKey(includeIfNull: false)
  final String? charset;

  @JsonKey(includeIfNull: false)
  final String? disposition;

  @JsonKey(includeIfNull: false)
  final String? cid;

  @JsonKey(includeIfNull: false)
  final Set<String>? language;

  @JsonKey(includeIfNull: false)
  final String? location;

  @JsonKey(includeIfNull: false)
  final Set<EmailBodyPart>? subParts;

  EmailBodyPart({
    this.partId,
    this.blobId,
    this.size,
    this.headers,
    this.name,
    this.type,
    this.charset,
    this.disposition,
    this.cid,
    this.language,
    this.location,
    this.subParts,
  });

  factory EmailBodyPart.fromJson(Map<String, dynamic> json) => _$EmailBodyPartFromJson(json);

  Map<String, dynamic> toJson() => _$EmailBodyPartToJson(this);

  @override
  List<Object?> get props => [
    partId,
    blobId,
    size,
    headers,
    name,
    type,
    charset,
    disposition,
    cid,
    language,
    location,
    subParts
  ];
}

class PartId with EquatableMixin {
  final String value;

  PartId(this.value);

  @override
  List<Object?> get props => [value];
}