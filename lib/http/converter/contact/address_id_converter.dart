import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:json_annotation/json_annotation.dart';

class AddressIdConverter implements JsonConverter<AddressId, String> {
  const AddressIdConverter();

  @override
  AddressId fromJson(String json) => AddressId(json);

  @override
  String toJson(AddressId object) => object.value;
}


