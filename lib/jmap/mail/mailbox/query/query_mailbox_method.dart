
import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/query_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_filter_condition.dart';
import 'package:json_annotation/json_annotation.dart';

class QueryMailboxMethod extends QueryMethod with FilterAsTree, SortAsTree {

  QueryMailboxMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('Mailbox/query');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jmapMail
  };

  @override
  List<Object?> get props => [methodName, accountId, filter, limit];

  factory QueryMailboxMethod.fromJson(Map<String, dynamic> json) {
    return QueryMailboxMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String)
    )    
      ..sortAsTree = json['sortAsTree'] as bool?
      ..filterAsTree = json['filterAsTree'] as bool?
      ..filter = json['filter'] == null
          ? null
          : MailboxFilterCondition.fromJson(json['filter'] as Map<String, dynamic>)
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
    
    writeNotNull('sortAsTree', sortAsTree);
    writeNotNull('filterAsTree', filterAsTree);
    writeNotNull('filter', filter?.toJson());
    writeNotNull('limit', const UnsignedIntNullableConverter().toJson(limit));
    return val;
  }
}
mixin FilterAsTree {
  @JsonKey(includeIfNull: false)
  bool? filterAsTree;

  void addFilterAsTree(bool value) {
    filterAsTree = value;
  }
}

mixin SortAsTree {
  @JsonKey(includeIfNull: false)
  bool? sortAsTree;

  void addSortAsTree(bool value) {
    sortAsTree = value;
  }
}