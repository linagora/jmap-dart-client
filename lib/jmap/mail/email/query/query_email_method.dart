import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/query_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_filter_condition.dart';
import 'package:json_annotation/json_annotation.dart';

class QueryEmailMethod extends QueryMethod with OptionalCollapseThreads {

  QueryEmailMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Email/query');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail
  };

  @override
  List<Object?> get props => [methodName, accountId, limit, filter, sort];

  factory QueryEmailMethod.fromJson(Map<String, dynamic> json) {
    return QueryEmailMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String)
    )
      ..position = json['position'] as int?
      ..anchorOffset = json['anchorOffset'] as int?
      ..calculateTotal = json['calculateTotal'] as bool?
      ..collapseThreads = json['collapseThreads'] as bool?
      ..filter = json['filter'] == null
          ? null
          : EmailFilterCondition.fromJson(json['filter'] as Map<String, dynamic>)
      ..sort = (json['sort'] as List<dynamic>?)
          ?.map((e) => EmailComparator.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..anchor = const IdNullableConverter().fromJson(json['anchor'] as String?)
      ..limit = const UnsignedIntNullableConverter().fromJson(json['limit'] as int);
  }

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('position', position);
    writeNotNull('anchorOffset', anchorOffset);
    writeNotNull('calculateTotal', calculateTotal);
    writeNotNull('collapseThreads', collapseThreads);
    writeNotNull('filter', filter?.toJson());
    writeNotNull('sort', sort?.map((e) => e.toJson()).toList());
    writeNotNull('anchor', const IdNullableConverter().toJson(anchor));
    writeNotNull('limit', const UnsignedIntNullableConverter().toJson(limit));
    return val;
  }
}

mixin OptionalCollapseThreads {
  @JsonKey(includeIfNull: false)
  bool? collapseThreads;

  void addCollapseThreads(bool value) {
    collapseThreads = value;
  }
}