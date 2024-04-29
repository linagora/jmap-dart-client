import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class SetMethod<T> extends MethodRequiringAccountId
    with OptionalIfInState, OptionalCreate<T>, OptionalDestroy, OptionalUpdate, OptionalReferenceDestroy {
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
    this.ifInState = state;
  }
}

mixin OptionalCreate<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? create;

  void addCreates(Map<Id, T> creates) {
    if (create == null) {
      create = Map<Id, T>();
    }
    create?.addAll(creates);
  }

  void addCreate(Id id, T createItem) {
    if (create == null) {
      create = Map<Id, T>();
    }
    create?.addAll({id: createItem});
  }
}

mixin OptionalUpdate {
  @JsonKey(includeIfNull: false)
  Map<Id, PatchObject>? update;

  void addUpdates(Map<Id, PatchObject> updates) {
    if (update == null) {
      update = Map<Id, PatchObject>();
    }
    update?.addAll(updates);
  }
}

mixin OptionalDestroy {
  @JsonKey(includeIfNull: false)
  Set<Id>? destroy;

  void addDestroy(Set<Id> values) {
    if (destroy == null) {
      destroy = Set();
    }
    destroy?.addAll(values);
  }
}

mixin OptionalUpdateSingleton<T> {
  @JsonKey(includeIfNull: false)
  Map<Id, T>? updateSingleton;

  void addUpdatesSingleton(Map<Id, T> updates) {
    if (updateSingleton == null) {
      updateSingleton = Map<Id, T>();
    }
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
