import 'package:test/test.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:dartzz_gen_test/gen_test.dart';

void main() {
  group("basic case class facilities", () {
    test("property access", () {
      final cc = SimpleCaseClass(19, "Some text for testing");
      expect(cc.anInt, equals(19));
      expect(cc.aStr, equals("Some text for testing"));
    });

    test("equals", () {
      final cc = SimpleCaseClass(19, "Some text for testing");
      expect(SimpleCaseClass(19, "Some text for testing"), equals(cc));
      expect(SimpleCaseClass(20, "Some text for testing"), isNot(equals(cc)));
    });
  });

  group("nested case classes", () {
    test("equals compares deeply", () {
      final cc = CompoundCaseClass(GenericCaseClass("test", 55, 1),
          SimpleCaseClass(20, "so simple").some(), "AAA43");
      final eq = CompoundCaseClass(GenericCaseClass("test", 55, 1),
          SimpleCaseClass(20, "so simple").some(), "AAA43");
      final notEq = CompoundCaseClass(GenericCaseClass("test", 53, 1),
          SimpleCaseClass(20, "so simple").some(), "AAA43");

      expect(eq, equals(cc));
      expect(notEq, isNot(equals(cc)));
    });
  });
}
