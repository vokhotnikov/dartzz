import 'package:dartzz_core/dartzz_core.dart';
import 'package:meta/meta.dart';
import 'code_generator.dart';
import 'codegen_model.dart';

@immutable
class CodegenInstances {
  static final CodegenSource<CaseClassCode> caseClassCodegenInstance =
      _CaseClassCodegenInstance();
}

@immutable
class _CaseClassCodegenInstance extends CodegenSource<CaseClassCode>
    with CodegenSourceInstances {
  const _CaseClassCodegenInstance();

  @override
  ListK<CodeChunk> generateCode(CaseClassCode caseClassCode) {
    return [
      code("@immutable"),
      newline(),
      code("class "), // class
      code(caseClassCode.name),
      ...(caseClassCode.genericArgs.isEmpty)
          ? <CodeChunk>[]
          : intersperse(
                  caseClassCode.genericArgs
                      .map((a) => genericTypeArgSource.generateCode(a)),
                  code("<"),
                  code(","),
                  code(">"))
              .toList(),
      code('{'),
      newline(),
      ...caseClassCode.fields // fields
          .flatMap((f) => immutableFieldSource.generateCode(f))
          .toList(),
      newline(),
      newline(),
      code("@protected"), // prototype ref
      newline(),
      code("Type get zz_proto => _${caseClassCode.name};"),
      newline(),
      newline(),
      code("const ${caseClassCode.name}("), // constructor
      ...caseClassCode.fields.map((f) => code("this.${f.name},")).toList(),
      code(");"),
      newline(),
      newline(),
      code("@override"), // toString
      newline(),
      code("String toString() => \""),
      code("${caseClassCode.name}("),
      ...intersperse(
              caseClassCode.fields.map(
                  (f) => [code("\${"), code(f.name), code(".toString()}")].k()),
              code(""),
              code(", "),
              code(""))
          .toList(),
      code(")"),
      code("\";"),
      newline(),
      newline(),
      code("@override"), // equals
      newline(),
      code("bool operator==(Object other) {"),
      newline(),
      code("return other is ${caseClassCode.name}"),
      ...caseClassCode.fields
          .map((f) => code(" && ${f.name} == other.${f.name}"))
          .toList(),
      code(";"),
      newline(),
      code("}"),
      newline(),
      newline(),
      code('// TODO: add hashcode'),
      newline(),
      code('}'),
      newline()
    ].k();
  }
}
