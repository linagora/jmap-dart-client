import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/blob/blob_data.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_blob_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable(explicitToJson: true)
class GetBlobResponse extends GetResponse<BlobData> {
  GetBlobResponse(
    AccountId accountId,
    State state,
    List<BlobData> list,
    List<Id>? notFound,
  ) : super(accountId, state, list, notFound);

  factory GetBlobResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBlobResponseFromJson(json);

  static GetBlobResponse deserialize(Map<String, dynamic> json) =>
      _$GetBlobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBlobResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
