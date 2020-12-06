import 'package:analyzer/dart/ast/ast.dart';
import 'package:dartzz_gen/src/codegen/codegen_model.dart';
import 'package:dartzz_gen/src/codegen/codegen_model_ops.dart';

import 'package:test/test.dart';
import 'package:dartzz_core/dartzz_core.dart';

void main() {
  test("type arg substitution", () {
    final from = ReferencedType("F", <ReferencedType>[].k());
    final to = ReferencedType("String", <ReferencedType>[].k());

    final subject = ReferencedType(
        "Subject", [ReferencedType("F", <ReferencedType>[].k())].k());

    final expected = ReferencedType(
        "Subject", [ReferencedType("String", <ReferencedType>[].k())].k());

    expect(
        substituteTypes(
            [Tuple2<ReferencedType, ReferencedType>(from, to)].k(), subject),
        equals(expected));
  });

  test("fix higher kinds", () {
    final from = ReferencedType(
        "Kind",
        [
          ReferencedType("ForOption", <ReferencedType>[].k()),
          ReferencedType("A", <ReferencedType>[].k())
        ].k());

    final expected = ReferencedType(
        "Option", [ReferencedType("A", <ReferencedType>[].k())].k());

    expect(fixHigherKinds(from), equals(expected));
  });

  test("remove generic func params", () {
    final f = FunctionOrMethod(
        "test",
        ReferencedType.simple("int"),
        [GenericTypeArg("A", none()), GenericTypeArg("B", none())].k(),
        [
          FunctionParameter(
              "f", ReferencedType("Option", [ReferencedType.simple("A")].k())),
          FunctionParameter(
              "mapper",
              ReferencedType("Func1",
                  [ReferencedType.simple("B"), ReferencedType.simple("A")].k()))
        ].k(),
        none(),
        false);

    final expected = FunctionOrMethod(
        f.name,
        f.returnType,
        [GenericTypeArg("B", none())].k(),
        f.parameters,
        f.body,
        f.returnsHigherKinded);

    expect(removeFuncTypeParameters(["A", "X"].k(), f), equals(expected));
  });
}
