import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../mail/email/email_body_properties.dart';

part 'parse_calender_method.g.dart';

@UnsignedIntNullableConverter()
@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable(explicitToJson: true)
class ParseCalenderMethod extends GetMethod with OptionalMaxBodyValueBytes {
  ParseCalenderMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('CalendarEvent/parse');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.calendarEvent};

  factory ParseCalenderMethod.fromJson(Map<String, dynamic> json) =>
      _$ParseCalenderMethodFromJson(json);

  Map<String, dynamic> toJson() => _$ParseCalenderMethodToJson(this);
  @override
  List<Object?> get props => [methodName, accountId, blobIds];
}

mixin OptionalMaxBodyValueBytes {
  @JsonKey(includeIfNull: false)
  UnsignedInt? maxBodyValueBytes;

  void addMaxBodyValueBytes(UnsignedInt value) {
    maxBodyValueBytes = value;
  }
}
