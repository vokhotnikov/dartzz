import 'package:test/test.dart';

import 'package:dartzz_core/dartzz_core.dart';

void main() {
  group("foldOption", () {
    test("fold None", () {
      expect(None<int>().foldOption(() => 42, (x) => x * 2), equals(42));
    });

    test("fold Some", () {
      expect(Some(13).foldOption(() => 42, (x) => x * 2), equals(26));
    });
  });

  group("option show", () {
    test("for none", () {
      expect(None<int>().show(zz.forInt.show), equals("None"));
    });

    test("for some", () {
      expect(Some(42).show(zz.forInt.show), equals("Some(42)"));
    });
  });

  group("option map", () {
    test("short-circuits none", () {
      expect(None<int>().map((x) => x * 2), equals(None<int>()));
    });

    test("cascade some", () {
      expect(Some(13).map((x) => x * 2).map((x) => x + 3), equals(Some(29)));
    });
  });
}
