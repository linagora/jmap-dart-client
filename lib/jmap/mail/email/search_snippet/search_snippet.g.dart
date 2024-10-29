// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_snippet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnippet _$SearchSnippetFromJson(Map<String, dynamic> json) =>
    SearchSnippet(
      emailId: const EmailIdConverter().fromJson(json['emailId'] as String),
      subject: json['subject'] as String?,
      preview: json['preview'] as String?,
    );

Map<String, dynamic> _$SearchSnippetToJson(SearchSnippet instance) {
  final val = <String, dynamic>{
    'emailId': const EmailIdConverter().toJson(instance.emailId),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subject', instance.subject);
  writeNotNull('preview', instance.preview);
  return val;
}
