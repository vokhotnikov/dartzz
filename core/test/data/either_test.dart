import 'package:test/test.dart';
import 'package:dartzz_core/dartzz_core.dart';

void main() {
  group('monadic', () {
    test("map syntax", () {
      expect(Right<String, String>("12").map((i) => int.parse(i)),
          equals(Right<String, int>(12)));
    });

    test("flatMap syntax", () {
      expect(
          Right<String, int>(13)
              .flatMap((i) => Right<String, double>(i.toDouble()))
              .flatMap((i) => Right<String, double>(i * 2)),
          equals(Right<String, double>(26.0)));
    });

    test("isLeft", () {
      expect("test".asLeft().isLeft, equals(true));
      expect(4.asRight().isLeft, equals(false));
    });

    test("isRight", () {
      expect("test".asLeft().isRight, equals(false));
      expect(4.asRight().isRight, equals(true));
    });
  });
}
