import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_address_book_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetAddressBookMethod extends GetMethod {
  GetAddressBookMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('AddressBook/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapContactCard};

  @override
  List<Object?> get props =>
      [methodName, accountId, ids, properties, requiredCapabilities];

  factory GetAddressBookMethod.fromJson(Map<String, dynamic> json) =>
      _$GetAddressBookMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetAddressBookMethodToJson(this);
}