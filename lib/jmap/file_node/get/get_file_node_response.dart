import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';
import '../file_node.dart';

part 'get_file_node_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetFileNodeResponse extends GetResponse<FileNode> {

  GetFileNodeResponse(
    AccountId accountId,
    State? state,
    List<FileNode>? list,
    List<Id>? notFound,
  ) : super(
          accountId,
          state ?? State(''),
          list ?? const <FileNode>[],
          notFound,
        );

  factory GetFileNodeResponse.fromJson(Map<String, dynamic> json) {
    final raw = _$GetFileNodeResponseFromJson(json);
    return GetFileNodeResponse(
      raw.accountId,
      raw.state,
      raw.list,
      raw.notFound,
    );
  }

  static GetFileNodeResponse deserialize(Map<String, dynamic> json) =>
      GetFileNodeResponse.fromJson(json);

  Map<String, dynamic> toJson() => _$GetFileNodeResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
