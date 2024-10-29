import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/email_id_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_snippet.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
  converters: [EmailIdConverter()]
)
class SearchSnippet with EquatableMixin {
  final EmailId emailId;
  final String? subject;
  final String? preview;

  SearchSnippet({
    required this.emailId,
    required this.subject,
    required this.preview,
  });

  factory SearchSnippet.fromJson(Map<String, dynamic> json) => _$SearchSnippetFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSnippetToJson(this);
  
  @override
  List<Object?> get props => [emailId, subject, preview];
}