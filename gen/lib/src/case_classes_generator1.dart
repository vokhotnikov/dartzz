import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:source_gen/source_gen.dart';

import 'visitors/extract_children.dart';
import 'codegen/codegen_model.dart';
import 'codegen/code_generator.dart';
import 'codegen/codegen_instances.dart';

class CaseClassesGenerator1 extends GeneratorForAnnotation<caseClass> {
  const CaseClassesGenerator1();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return zz
        .forEither<String>()
        .applicative
        .map3(_targetClassName(element), _extractTypeParams(element),
            _extractConstructorParams(element), (String className,
                ListK<TypeParameterElement> typeParams,
                ListK<ParameterElement> args) {
          final caseClass = CaseClassCode(
              className,
              typeParams.map((tpe) => GenericTypeArg(
                  tpe.name, Option.fromNullable(tpe.bound?.element?.name))),
              args.map((p) =>
                  ImmutableField(p.name, _referencedTypeFromDartType(p.type))),
              <FunctionOrMethod>[].k());

          return renderChunks(CodegenInstances.caseClassCodegenInstance
              .generateCode(caseClass));
        })
        .fix()
        .foldEither((err) => throw InvalidGenerationSourceError(err), (b) => b);
  }

  // TODO: replace with monoid/fold?
  String renderChunks(ListK<CodeChunk> chunks) {
    final res = StringBuffer();
    res.writeAll(chunks.map((c) => c.code).toList());
    return res.toString();
  }

  ReferencedType _referencedTypeFromDartType(DartType t) {
    return ReferencedType(
        _typeNameForPossibleProto(t),
        t is ParameterizedType
            ? t.typeArguments.k().map(_referencedTypeFromDartType)
            : <ReferencedType>[].k());
  }

  String _typeNameForPossibleProto(DartType dartType) {
    if (TypeChecker.fromRuntime(
            caseClass) // TODO this must be centralized and generalized as soon as new proto generators appear
        .hasAnnotationOfExact(dartType.element)) {
      return dartType.element.name.substring(1);
    } else {
      return dartType.element.name;
    }
  }

  Either<String, String> _targetClassName(Element element) => (element.name
          .startsWith('_'))
      ? element.name.substring(1).asRight<String>()
      : "Classes marked with @caseclass should be private (start with _): ${element.name}"
          .asLeft<String>();

  Either<String, ListK<ParameterElement>> _extractConstructorParams(
      Element element) {
    return element.listChildren<ConstructorElement>().asRight<String>().flatMap(
        (cs) => cs.length > 1
            ? "@caseclass class must have exactly one constructor, but ${element.name} has ${cs.length}"
                .asLeft<ListK<ParameterElement>>()
            : cs.headOption().foldOption(
                () =>
                    "@caseclass class must have a constructor, but ${element.name} has none"
                        .asLeft<ListK<ParameterElement>>(),
                (c) => c.listChildren<ParameterElement>().asRight<String>()));
  }

  Either<String, ListK<TypeParameterElement>> _extractTypeParams(
          Element element) =>
      element.listChildren<TypeParameterElement>().asRight<String>();
}
