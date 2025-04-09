import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/email_id_converter.dart';
import 'package:jmap_dart_client/http/converter/thread_id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable(
  includeIfNull: false,
  converters: [ThreadIdNullableConverter(), EmailIdConverter()],
)
class Thread with EquatableMixin {
  final ThreadId? id;
  final List<EmailId>? emailIds;

  const Thread({this.id, this.emailIds});

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);

  @override
  List<Object?> get props => [id, emailIds];
}