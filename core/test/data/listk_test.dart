import 'package:dartzz_core/dartzz_core.dart';

import 'package:test/test.dart';

void main() {
  group("ListK operations", () {
    test("map works", () {
      final actual = <int>[2, 3, 5, 7].k().map((x) => x - 1);
      expect(actual.toList(), equals(<int>[1, 2, 4, 6]));
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

    test("head option", () {
      expect(<int>[1, 3, 0].k().headOption(), equals(1.some()));
      expect(<int>[].k().headOption(), equals(none()));
    });

    test("flatten list of options", () {
      final l = <Option<int>>[
        none(),
        1.some(),
        3.some(),
        none(),
        0.some(),
        none()
      ].k();

      expect(l.flatten(), equals(<int>[1, 3, 0].k()));
    });

    test("add element", () {
      expect(<int>[].k().add(17), equals(<int>[17].k()));
      expect([-9, 10, 0].k().add(0), equals([-9, 10, 0, 0].k()));
    });

    test("element at index", () {
      final l = <int>[3, 0, -9, 1].k();

      expect(l.atOption(-1), equals(None()));
      expect(l.atOption(0), equals(Some(3)));
      expect(l.atOption(2), equals(Some(-9)));
      expect(l.atOption(4), equals(None()));
      expect(l.atOption(666), equals(None()));
    });

    test("concat lists", () {
      final l1 = <int>[1, 4, 0].k();
      final l2 = <int>[-19, 1].k();

      expect(<int>[].k().concat(l1), equals(l1));
      expect(l1.concat(<int>[].k()), equals(l1));
      expect(l1.concat(l2), equals(<int>[1, 4, 0, -19, 1].k()));
      expect(l2.concat(l1), equals(<int>[-19, 1, 1, 4, 0].k()));
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
