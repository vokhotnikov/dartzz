import 'package:dartzz/dartzz.dart';

import 'package:test/test.dart';

void main() {
  group("ListK operations", () {
    test("map works", () {
      final actual = <int>[2,3,5,7].k().map((x) => x - 1);
      expect(actual.toList(), equals(<int>[1,2,4,6]));
    });

    test("flat map works", () {
      final l1 = <int>[0, 2, 4].k();
      final l2 = <int>[1, -1].k();

      final actual = l1.flatMap((i) => l2.map((j) => i * j)).toList();
      expect(actual, equals(<int>[0, 0, 2, -2, 4, -4]));
    });

    test("filter works", () {

      final l = <int>[0, 0, 2, -2, 4, -4].k();
      expect(l.filter((x) => x > 1).toList(), equals(<int>[2, 4]));
    });

    test("better comprehension syntax", () {
      final l1 = <int>[0, 2, 4].k();
      final l2 = <int>[1, -1].k();

      // final actual = zz.forListK.monad.binding(() {
      //   final i = l1.bind();
      //   final j = l2.bind();
      //   final res = (i * j).filter((x) => x > 1)
      //   return res;
      // });

      // expect(actual, equals(<int>[2, 4]));
    });
  });
}