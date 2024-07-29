import 'package:test/test.dart';
import 'package:jmap_dart_client/jmap/core/reference_prefix.dart';

void main() {
  group('Invalid reference_prefix', () {
    test('Should throw argument error when the reference_prefix is empty', () {
      expect(() => ReferencePrefix(''), throwsArgumentError);
    });

    test(
        'Should throw argument error when the reference_prefix has length more than 255',
        () {
      expect(
          () => ReferencePrefix(
              'a123bde34588799922229339933933933993939393939222a123bde34'
              '588799922229339933933933993939393939222a123be3458879992222933993393393'
              '3993939393939222a123bde34588799922229339933933933993939393939222a123bd'
              'e34588799922229339933933933993939393939222a123bde345887999222293399339'
              '33933993939393939222a123bde34588799922229339933933933993939393939222a1'
              '23bde34588799922229339933933933993939393939222111111111111111111111111'),
          throwsArgumentError);
    });
  });
}
