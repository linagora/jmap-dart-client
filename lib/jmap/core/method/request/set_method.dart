import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class SetMethod<T> extends MethodRequiringAccountId
    with OptionalIfInState, OptionalCreate<T>, OptionalDestroy, OptionalUpdate,
    OptionalReferenceDestroy {
  SetMethod(AccountId accountId) : super(accountId);
}

abstract class SetMethodNoNeedAccountId<T> extends Method
    with OptionalCreate<T>, OptionalDestroy, OptionalUpdate, OptionalReferenceDestroy {
  SetMethodNoNeedAccountId() : super();
}

mixin OptionalIfInState {
  @JsonKey(includeIfNull: false)
  State? ifInState;

  void addIfInState(State? state) {
    ifInState = state;
  }
}

mixin OptionalCreate<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? create;

  void addCreates(Map<Id, T> creates) {
    create ??= <Id, T>{};
    create?.addAll(creates);
  }

  void addCreate(Id id, T createItem) {
    create ??= <Id, T>{};
    create?.addAll({id: createItem});
  }
}

mixin OptionalUpdate {
  @JsonKey(includeIfNull: false)
  Map<Id, PatchObject>? update;

  void addUpdates(Map<Id, PatchObject> updates) {
    update ??= <Id, PatchObject>{};
    update?.addAll(updates);
  }
}

mixin OptionalDestroy {
  @JsonKey(includeIfNull: false)
  Set<Id>? destroy;

  void addDestroy(Set<Id> values) {
    destroy ??= <Id>{};
    destroy?.addAll(values);
  }
}

mixin OptionalUpdateSingleton<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? updateSingleton;

  void addUpdatesSingleton(Map<Id, T> updates) {
    updateSingleton ??= <Id, T>{};
    updateSingleton?.addAll(updates);
  }
}

mixin OptionalReferenceDestroy {
  @JsonKey(name: '#destroy', includeIfNull: false)
  ResultReference? referenceDestroy;

  void addReferenceDestroy(ResultReference resultReferenceDestroy) {
    referenceDestroy = resultReferenceDestroy;
  }
}
