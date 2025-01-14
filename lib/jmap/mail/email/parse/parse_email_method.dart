import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/parse_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_properties.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_method.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parse_email_method.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  converters: [
    AccountIdConverter(),
    IdConverter(),
    UnsignedIntNullableConverter(),
    PropertiesConverter(),
  ],
)
class ParseEmailMethod extends ParseMethod
    with
        OptionalEmailBodyProperties,
        OptionalFetchTextBodyValues,
        OptionalFetchHTMLBodyValues,
        OptionalFetchAllBodyValues,
        OptionalMaxBodyValueBytes {

  ParseEmailMethod(super.accountId, super.blobIds);

  @override
  MethodName get methodName => MethodName('Email/parse');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail,
  };

  factory ParseEmailMethod.fromJson(Map<String, dynamic> json) => _$ParseEmailMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ParseEmailMethodToJson(this);

  @override
  List<Object?> get props => [
    accountId,
    blobIds,
    properties,
    bodyProperties,
    fetchTextBodyValues,
    fetchHTMLBodyValues,
    fetchAllBodyValues,
    maxBodyValueBytes,
  ];
}