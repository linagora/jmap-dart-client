import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';

class RelationConverter {
  MapEntry<Relation, bool> parseEntry(String key, bool value) => MapEntry(Relation(key), value);

  MapEntry<String, bool> toJson(Relation relationValue, bool value) => MapEntry(relationValue.value, value);
}

