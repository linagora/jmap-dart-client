import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';

abstract class GetMethod extends MethodRequiringAccountId with OptionalIds, OptionalProperties {
  GetMethod(AccountId accountId) : super(accountId);
}

mixin OptionalIds {
  Set<Id>? ids;

  void addIds(Set<Id> values) {
    if (ids == null) {
      ids = Set();
    }
    ids?.addAll(values);
  }
}

mixin OptionalProperties {
  Properties? properties = Properties.empty();

  void addProperties(Properties other) {
    properties = properties?.union(other);
  }
}
