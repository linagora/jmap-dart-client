// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_snippet_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSnippetGetResponse _$SearchSnippetGetResponseFromJson(
        Map<String, dynamic> json) =>
    SearchSnippetGetResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      (json['list'] as List<dynamic>?)
          ?.map((e) => SearchSnippet.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$SearchSnippetGetResponseToJson(
    SearchSnippetGetResponse instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('list', instance.list?.map((e) => e.toJson()).toList());
  writeNotNull(
      'notFound', instance.notFound?.map(const IdConverter().toJson).toList());
  return val;
}
