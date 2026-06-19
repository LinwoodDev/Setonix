import 'package:flutter_test/flutter_test.dart';
import 'package:setonix/helpers/string.dart';

void main() {
  group('StringHelper', () {
    test('equalsIgnoreCase only matches complete strings', () {
      expect('Setonix'.equalsIgnoreCase('setonix'), isTrue);
      expect('Setonix'.equalsIgnoreCase('set'), isFalse);
    });

    test('containsIgnoreCase matches substrings', () {
      expect('Linwood Setonix'.containsIgnoreCase('SETONIX'), isTrue);
      expect('Linwood Setonix'.containsIgnoreCase('swamp'), isFalse);
    });
  });
}
