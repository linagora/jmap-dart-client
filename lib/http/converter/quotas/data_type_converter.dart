import 'package:jmap_dart_client/jmap/quotas/data_types.dart';
import 'package:json_annotation/json_annotation.dart';

class DataTypeConverter implements JsonConverter<DataType, String> {
  const DataTypeConverter();

  @override
  DataType fromJson(String json) => DataType(json);

  @override
  String toJson(DataType object) => object.value;
}