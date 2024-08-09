import 'package:test/test.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';

void main() {
  group('test union', () {
    test('empty properties should union other properties', () {
      final emptyProperties = Properties.empty();

      expect(
        emptyProperties.union(Properties({'id', 'name'})),
        equals(Properties({'id', 'name'}))
      );
    });

    test('properties should union other properties', () {
      final properties = Properties({'role'});
      final unionProperties = properties.union(Properties({'id', 'name'}));

      expect(
        unionProperties,
        equals(Properties({'role', 'id', 'name'}))
      );
    });
  });

  group('test removeAll', () {
    test('empty properties should not remove anything', () {
      final emptyProperties = Properties.empty();

      expect(
          emptyProperties.removeAll(Properties({'id', 'name'})),
          equals(emptyProperties)
      );
    });

    test('two-item properties should remove all item when remove three-item properties', () {
      final twoItem = Properties({
        'id',
        'name'
      });

      expect(
          twoItem.removeAll(Properties({'id', 'name', 'role'})),
          equals(Properties.empty())
      );
    });

    test('properties can remove all contained items', () {
      final properties = Properties({
        'id',
        'name',
        'role'
      });

      expect(
          properties.removeAll(Properties({'id', 'name'})),
          equals(Properties({'role'}))
      );
    });
  });
}