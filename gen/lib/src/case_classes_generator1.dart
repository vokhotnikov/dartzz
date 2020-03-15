import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:source_gen/source_gen.dart';

import 'visitors/extract_children.dart';
import 'codegen/codegen_model.dart';

class CaseClassesGenerator1 extends GeneratorForAnnotation<caseClass> {
  const CaseClassesGenerator1();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return zz.forEither<String>().applicative.map3(
        _targetClassName(element),
        _extractTypeParams(element),
        _extractConstructorParams(element),
        (String className, ListK<TypeParameterElement> typeParams,
                ListK<ParameterElement> args) =>
                CaseClassCode(className, 
                typeParams.map((tpe) => GenericTypeArg(tpe.name, Option.fromNullable(tpe.bound?.element?.name))), 
                args.map((p) => ImmutableField(p.name, ReferencedType(p.type.getDisplayString()))),
                [].k())
            );
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
