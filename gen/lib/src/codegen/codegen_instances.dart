import 'package:dartzz_core/dartzz_core.dart';
import 'package:meta/meta.dart';
import 'code_generator.dart';
import 'codegen_model.dart';

@immutable
class CodegenInstances {
  static final CodegenSource<CaseClassCode> caseClassCodegenInstance =
      _CaseClassCodegenInstance();

  static final CodegenSource<TypeclassSyntaxProxyExtension>
      typeclassSyntaxProxyExtensionCodegenInstance =
      _TypeclassSyntaxProxyExtensionCodegenInstance();
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

class _TypeclassSyntaxProxyExtensionCodegenInstance
    extends CodegenSource<TypeclassSyntaxProxyExtension>
    with CodegenSourceInstances {
  @override
  ListK<CodeChunk> generateCode(TypeclassSyntaxProxyExtension proxy) {
    return <CodeChunk>[
      code("// proxy will be generated here"),
      newline(),
      code("extension ${proxy.subjectType.name}__${proxy.typeclass.name}__Ext"),
      ...intersperse(
              proxy.subjectType.typeArgs
                  .map((ta) => referencedTypeSource.generateCode(ta)),
              code("<"),
              code(","),
              code(">"))
          .toList(),
      code(" on "),
      ...referencedTypeSource.generateCode(proxy.subjectType).toList(),
      code(" {"),
      newline(),
      code("static const syntax = "),
      ...referencedTypeSource.generateCode(proxy.syntaxType).toList(),
      code("("),
      ...referencedTypeSource.generateCode(proxy.instanceType).toList(),
      code("());"),
      newline(),
      newline(),
      code("// methods will be here"),
      newline(),
      ...proxy.proxiedMethods
          .flatMap((m) => <CodeChunk>[
                ...referencedTypeSource.generateCode(m.returnType).toList(),
                code(" ${m.name}"),
                ...intersperse(
                        m.genericParams
                            .map((t) => genericTypeArgSource.generateCode(t)),
                        code("<"),
                        code(","),
                        code(">"))
                    .toList(),
                code("("),
                ...intersperse(
                        m.parameters
                            .tailOption()
                            .getOrElse(<FunctionParameter>[].k())
                            .map((p) => <CodeChunk>[
                                  ...referencedTypeSource
                                      .generateCode(p.type)
                                      .toList(),
                                  code(" ${p.name}")
                                ].k()),
                        code(""),
                        code(","),
                        code(""))
                    .toList(),
                code(") => syntax.${m.name}(this"),
                ...m.parameters
                    .tailOption()
                    .getOrElse(<FunctionParameter>[].k())
                    .flatMap((p) => <CodeChunk>[code(", ${p.name}")].k())
                    .toList(),
                code(")"),
                ...(m.returnsHigherKinded) ? [code(".fix()")] : [],
                code(";"),
                newline()
              ].k())
          .toList(),
      newline(),
      code("}")
    ].k();
  }
}
