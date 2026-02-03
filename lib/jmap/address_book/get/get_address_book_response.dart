import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/address_book/address_book.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_address_book_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetAddressBookResponse extends GetResponse<AddressBook> {
  GetAddressBookResponse(
    AccountId accountId,
    State? state,
    List<AddressBook>? list,
    List<Id>? notFound,
  ) : super(
          accountId,
          state ?? State(''),
          list ?? const <AddressBook>[],
          notFound,
        );

  factory GetAddressBookResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAddressBookResponseFromJson(json);

  static GetAddressBookResponse deserialize(Map<String, dynamic> json) {
    return GetAddressBookResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAddressBookResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}