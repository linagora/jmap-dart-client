import 'package:test/test.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';

void main() {
  group('invalid id', () {
    test('should throw argument error when the id is empty', () {
      expect(() => Id(''), throwsArgumentError);
    });

    test('should throw argument error when the id has length more than 255', () {
      expect(
        () => Id('a123bde34588799922229339933933933993939393939222a123bde34'
          '588799922229339933933933993939393939222a123be3458879992222933993393393'
          '3993939393939222a123bde34588799922229339933933933993939393939222a123bd'
          'e34588799922229339933933933993939393939222a123bde345887999222293399339'
          '33933993939393939222a123bde34588799922229339933933933993939393939222a1'
          '23bde34588799922229339933933933993939393939222'),
        throwsArgumentError
      );
    });

    test('should throw argument error when the id start with dash', () {
      expect(() => Id('_abe23abc'), throwsArgumentError);
    });
  });
}