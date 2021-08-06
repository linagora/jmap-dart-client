import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_body_properties.g.dart';

@JsonSerializable()
class EmailBodyProperties extends Properties {
  static EmailBodyProperties defaultEmailBodyProperties = EmailBodyProperties({
    'partId', 'blobId', 'size', 'name', 'type', 'charset',
    'disposition', 'cid', 'language', 'location'
  });

  EmailBodyProperties(Set<String> value) : super(value);

  factory EmailBodyProperties.fromJson(Map<String, dynamic> json) => _$EmailBodyPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$EmailBodyPropertiesToJson(this);

  @override
  List<Object?> get props => [value];
}