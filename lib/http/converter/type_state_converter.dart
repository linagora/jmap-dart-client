import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/push/type_state.dart';

class TypeStateConverter {
  static final defaultConverter = TypeStateConverter();

  BuiltMap<AccountId, TypeState Function(Map<String, dynamic>)>? mapTypeStateConverter;
  final _mapTypeStateConverterBuilder = MapBuilder<AccountId, TypeState Function(Map<String, dynamic>)>();

  TypeStateConverter();

  void addConverters(Map<AccountId, TypeState Function(Map<String, dynamic>)> converters) {
    _mapTypeStateConverterBuilder.addAll(converters);
  }

  void build() {
    mapTypeStateConverter = _mapTypeStateConverterBuilder.build();
  }

  BuiltMap<AccountId, Function>? getConverters() {
    return mapTypeStateConverter;
  }

  MapEntry<AccountId, TypeState> convert(String key, dynamic value) {
    if (mapTypeStateConverter == null) {
      build();
    }

    final identifier = AccountId(Id(key));
    if (mapTypeStateConverter!.containsKey(identifier)) {
      return MapEntry(identifier, mapTypeStateConverter![identifier]!.call(value));
    } else {
      return MapEntry(identifier, TypeState(value));
    }
  }
}