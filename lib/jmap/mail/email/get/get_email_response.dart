import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/email_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:jmap_dart_client/jmap/core/extensions/utc_date_extension.dart';
import 'package:jmap_dart_client/jmap/core/extensions/string_extension.dart';
import 'package:jmap_dart_client/jmap/core/extensions/unsigned_int_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_response.g.dart';

@EmailConverter()
@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetEmailResponse extends GetResponse<Email> {
  GetEmailResponse(AccountId accountId, State state, List<Email> list, List<Id>? notFound) : super(accountId, state, list, notFound);

  factory GetEmailResponse.fromJson(Map<String, dynamic> json) => _$GetEmailResponseFromJson(json);

  static GetEmailResponse deserialize(Map<String, dynamic> json) {
    return GetEmailResponse.fromJson(json);
  }

  void sortEmails(Comparator comparator) {
    list.sort((email1, email2) {
      if (comparator.property == EmailComparatorProperty.sentAt) {
        return email1.sentAt.compareToSort(email2.sentAt, comparator.isAscending);
      } if (comparator.property == EmailComparatorProperty.receivedAt) {
        return email1.receivedAt.compareToSort(email2.receivedAt, comparator.isAscending);
      } if (comparator.property == EmailComparatorProperty.subject) {
        return email1.subject.compareToSort(email2.subject, comparator.isAscending);
      } if (comparator.property == EmailComparatorProperty.size) {
        return email1.size.compareToSort(email2.size, comparator.isAscending);
      } else {
        return 0;
      }
    });
  }

  Map<String, dynamic> toJson() => _$GetEmailResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}