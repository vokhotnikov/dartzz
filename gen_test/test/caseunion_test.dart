import 'package:test/test.dart';
import 'package:dartzz_gen_test/gen_test.dart';

void main() {
  group("Simple union", () {
    test("Union creation", () {
      final i1 = FirstSubtype(12, "abc");
      final i2 = SecondSubtype(false);

      expect(i1, isA<UnionForTesting>());
      expect(i2, isA<UnionForTesting>());
      expect(i1, isNot(equals(i2)));
    });
  });
}