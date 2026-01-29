import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:json_annotation/json_annotation.dart';

class AnniversaryIdConverter implements JsonConverter<AnniversaryId, String> {
  const AnniversaryIdConverter();

  @override
  AnniversaryId fromJson(String json) => AnniversaryId(json);

  @override
  String toJson(AnniversaryId object) => object.value;
}


