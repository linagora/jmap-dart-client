import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/mdn/mdn_converter.dart';
import 'package:jmap_dart_client/http/converter/set_error_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';

class SendMessageResponse extends ResponseRequiringAccountId
    with OptionalSentProperty, OptionalNotSentProperty {
  SendMessageResponse(AccountId accountId) : super(accountId);

  static SendMessageResponse deserialize(Map<String, dynamic> json) {
    var sendMessageResponse = SendMessageResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
    );

    if (json['send'] != null) {
      sendMessageResponse.addSentProperty((json['send'] as Map<String, dynamic>)
          .map((key, value) => MdnConverter().parseEntry(key, value)));
    }

    if (json['notSent'] != null) {
      sendMessageResponse.addNotSentProperty(
          (json['notSent'] as Map<String, dynamic>)
              .map((key, value) => SetErrorConverter().parseEntry(key, value)));
    }

    return sendMessageResponse;
  }

  @override
  List<Object?> get props => [accountId, send, notSent];
}

mixin OptionalSentProperty {
  Map<Id, Mdn>? send;

  void addSentProperty(Map<Id, Mdn>? sentProperty) {
    send = sentProperty;
  }
}

mixin OptionalNotSentProperty {
  Map<Id, SetError>? notSent;

  void addNotSentProperty(Map<Id, SetError> notSentProperty) {
    notSent = notSentProperty;
  }
}
