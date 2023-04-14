import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class GetMethod extends MethodRequiringAccountId
    with
        AdditionalBlobIds,
        OptionalIds,
        OptionalProperties,
        OptionalReferenceIds,
        OptionalReferenceProperties {
  GetMethod(AccountId accountId) : super(accountId);
}

abstract class GetMethodNoNeedAccountId extends Method
    with
        AdditionalBlobIds,
        OptionalIds,
        OptionalProperties,
        OptionalReferenceIds,
        OptionalReferenceProperties {
  GetMethodNoNeedAccountId() : super();
}

mixin AdditionalBlobIds {
  List<String>? blobIds;
  void addString(String newString) {
    if (blobIds == null) {
      blobIds = [newString];
    } else {
      blobIds!.add(newString);
    }
  }
}

mixin OptionalIds {
  @JsonKey(includeIfNull: false)
  Set<Id>? ids;

  void addIds(Set<Id> values) {
    if (ids == null) {
      ids = Set();
    }
    ids?.addAll(values);
  }
}

mixin OptionalReferenceIds {
  @JsonKey(name: '#ids', includeIfNull: false)
  ResultReference? referenceIds;

  void addReferenceIds(ResultReference resultReferenceIds) {
    referenceIds = resultReferenceIds;
  }
}

mixin OptionalProperties {
  @JsonKey(includeIfNull: false)
  Properties? properties = Properties.empty();

  void addProperties(Properties other) {
    properties = properties?.union(other);
  }
}

mixin OptionalReferenceProperties {
  @JsonKey(name: '#properties', includeIfNull: false)
  ResultReference? referenceProperties;

  void addReferenceProperties(ResultReference resultReferenceProperties) {
    referenceProperties = resultReferenceProperties;
  }
}
