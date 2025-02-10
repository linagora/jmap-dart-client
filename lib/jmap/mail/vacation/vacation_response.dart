import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/vacation/vacation_id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vacation_response.g.dart';

@VacationIdNullableConverter()
@UTCDateNullableConverter()
@JsonSerializable(explicitToJson: true)
class VacationResponse with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final VacationId? id;

  @JsonKey(includeIfNull: false)
  final bool? isEnabled;

  final UTCDate? fromDate;

  final UTCDate? toDate;

  final String? subject;

  final String? textBody;

  final String? htmlBody;

  VacationResponse({
    this.id,
    this.isEnabled,
    this.fromDate,
    this.toDate,
    this.subject,
    this.textBody,
    this.htmlBody
  });

  factory VacationResponse.fromJson(Map<String, dynamic> json) => _$VacationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VacationResponseToJson(this);

  @override
  List<Object?> get props => [
    id,
    isEnabled,
    fromDate,
    toDate,
    subject,
    textBody,
    htmlBody
  ];
}