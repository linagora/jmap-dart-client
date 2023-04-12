import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_method.g.dart';

@UnsignedIntNullableConverter()
@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(explicitToJson: true)
class GetEmailMethod extends GetMethod with OptionalEmailBodyProperties, OptionalFetchTextBodyValues,
    OptionalFetchHTMLBodyValues, OptionalFetchAllBodyValues, OptionalMaxBodyValueBytes {

  GetEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Email/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail
  };
  
  @override
  List<Object?> get props => [methodName, accountId, ids, properties, requiredCapabilities];

  factory GetEmailMethod.fromJson(Map<String, dynamic> json) => _$GetEmailMethodFromJson(json);

  Map<String, dynamic> toJson() => _$GetEmailMethodToJson(this);
}

mixin OptionalEmailBodyProperties {
  @JsonKey(includeIfNull: false)
  EmailBodyProperties? bodyProperties;

  void addEmailBodyProperties(EmailBodyProperties value) {
    bodyProperties = value;
  }
}

mixin OptionalFetchTextBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchTextBodyValues;

  void addFetchTextBodyValues(bool value) {
    fetchTextBodyValues = value;
  }
}

mixin OptionalFetchHTMLBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchHTMLBodyValues;

  void addFetchHTMLBodyValues(bool value) {
    fetchHTMLBodyValues = value;
  }
}

mixin OptionalFetchAllBodyValues {
  @JsonKey(includeIfNull: false)
  bool? fetchAllBodyValues;

  void addFetchAllBodyValues(bool value) {
    fetchAllBodyValues = value;
  }
}

mixin OptionalMaxBodyValueBytes {
  @JsonKey(includeIfNull: false)
  UnsignedInt? maxBodyValueBytes;

  void addMaxBodyValueBytes(UnsignedInt value) {
    maxBodyValueBytes = value;
  }
}