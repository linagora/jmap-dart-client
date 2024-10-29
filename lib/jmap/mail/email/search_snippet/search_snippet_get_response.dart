import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/search_snippet/search_snippet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_snippet_get_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
  converters: [
    AccountIdConverter(),
    IdConverter(),
  ]
)
class SearchSnippetGetResponse extends ResponseRequiringAccountId {
  SearchSnippetGetResponse(
    super.accountId,
    this.list,
    this.notFound,
  );

  final List<SearchSnippet>? list;
  final List<Id>? notFound;

  factory SearchSnippetGetResponse.fromJson(Map<String, dynamic> json) => _$SearchSnippetGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSnippetGetResponseToJson(this);

  @override
  List<Object?> get props => [accountId, list, notFound];
}