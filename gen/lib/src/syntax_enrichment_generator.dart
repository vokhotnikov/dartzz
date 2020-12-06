import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/experiments.dart';
import 'package:dartzz_gen/src/codegen/codegen_instances.dart';
import 'package:dartzz_gen/src/codegen/codegen_model.dart';
import 'package:meta/meta.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

import 'visitors/extract_children.dart';
import 'visitors/reflect_element_tree.dart';

import 'ast_analysis_helpers.dart';
import 'codegen/codegen_model_ops.dart';

@immutable
class SyntaxEnrichmentGenerator extends Generator {
  const SyntaxEnrichmentGenerator();

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    const instanceChecker =
        TypeChecker.fromRuntime(TypeclassInstanceAnnotation);

    if (!library.classes
        .any((element) => instanceChecker.hasAnnotationOfExact(element))) {
      return null;
    }

    var res = StringBuffer();

    final instances = library.classes
        .where((c) => instanceChecker.hasAnnotationOfExact(c))
        .toList()
        .k();

    res.write("// Found ${instances.length} instances\n");

    final proxies = instances
        .flatMap((i) => _constructProxyExtensions(i, library.element, res));

    res.writeln("// Constructed ${proxies.length} proxy extensions");

    proxies.map((p) => res
      ..writeAll(CodegenInstances.typeclassSyntaxProxyExtensionCodegenInstance
          .generateCode(p)
          .map((c) => c.code)
          .toList())
      ..writeln());

    return res.toString();
  }

  ListK<TypeclassSyntaxProxyExtension> _constructProxyExtensions(
      ClassElement instanceElement, LibraryElement library, StringBuffer res) {
    const syntaxChecker = TypeChecker.fromRuntime(TypeclassSyntaxAnnotation);

    final instanceType = referencedTypeFromDartType(instanceElement.thisType);
    res.writeln("// Instance type: ${instanceType}");
    if (!instanceType.typeArgs.isEmpty) {
      return <TypeclassSyntaxProxyExtension>[].k();
    }

    res.writeln("// Raw instance supertype: ${instanceElement.supertype}");

    final typeclassType =
        fixHigherKinds(referencedTypeFromDartType(instanceElement.supertype));
    final maybeRawSubjectType = typeclassType.typeArgs.headOption();

    res.writeln("// Typeclass type: ${typeclassType}");

    ListK<Tuple2<ReferencedType, ListK<FunctionOrMethod>>>
        syntaxTypesAndMethods =
        findClasses(library, (c) => syntaxChecker.hasAnnotationOfExact(c))
            .filter((c) =>
                c.constructors.length == 1 &&
                c.constructors[0].parameters
                    .k()
                    .headOption()
                    .map((p1) =>
                        referencedTypeFromDartType(p1.type).name ==
                        typeclassType.name)
                    .getOrElse(false))
            .map((a) {
      final syntaxType = referencedTypeFromDartType(a.thisType);
      final substituteSyntaxType = zz.forOption.applicative
          .map2(syntaxType.typeArgs.headOption(), maybeRawSubjectType,
              (a1, rawSubjectType) {
            res.writeln(
                "// scheduling syntax type substitution ${a1.toString()} -> ${rawSubjectType.toString()}");
            return (t) => fixHigherKinds(substituteTypes(
                [Tuple2<ReferencedType, ReferencedType>(a1, rawSubjectType)]
                    .k(),
                t));
          })
          .fix()
          .getOrElse((t) => t);
      return Tuple2(
          substituteSyntaxType(syntaxType),
          a.listChildren<MethodElement>().map((e) {
            res.writeln(_printMethodInfo(e));
            return parseFunctionOrMethod(e);
          }).map((m) => applyFuncTypeSubstitutions(
                  (t) => substituteSyntaxType(t).some(), m)
              .getOrElse(m)));
    });

    return maybeRawSubjectType.map((rawSubjectType) {
      final subjectType = fixHigherKinds(
          higherKindMarkerToGenericKind(rawSubjectType)
              .getOrElse(rawSubjectType));

      res.writeln("// Subject type: ${subjectType}");
      return syntaxTypesAndMethods.map((syntaxTypeAndMethods) {
        res.writeln("// Syntax type: ${syntaxTypeAndMethods.it1}");
        return TypeclassSyntaxProxyExtension(
            subjectType: subjectType,
            typeclass: typeclassType,
            instanceType: instanceType,
            syntaxType: syntaxTypeAndMethods.it1,
            proxiedMethods: syntaxTypeAndMethods.it2.map((f) =>
                removeFuncTypeParameters(
                    subjectType.typeArgs
                        .filter((t) => t.typeArgs.isEmpty)
                        .map((t) => t.name),
                    f)));
      });
    }).getOrElse(<TypeclassSyntaxProxyExtension>[].k());
  }

  String _printElementsTree(List<ElementWithLevel> elements) {
    var b = StringBuffer();
    b.writeAll(
        elements.map((e) =>
            "// ${'  ' * e.depthLevel}${e.element.runtimeType} ${e.element.name} (${e.element.toString()})"),
        '\n');
    return b.toString();
  }

  String _printMethodInfo(MethodElement el) {
    final visitor = ReflectElementTreeVisitor(el);
    el.visitChildren(visitor);

    var res = StringBuffer();
    res
      ..writeln("// Method ${el.name}")
      ..writeln("// params: ${el.parameters}")
      ..writeln("// param types: ${el.parameters.map((p) => p.type)}")
      ..writeln(
          "// param runtime type: ${el.parameters.map((p) => p.type.runtimeType)}")
      ..writeln(_printElementsTree(visitor.result));
    return res.toString();
  }

  String _printClassInfo(ClassElement el) {
    final visitor = ReflectElementTreeVisitor(el);
    el.visitChildren(visitor);

    final firstContructorParam = el
        .listChildren<ConstructorElement>()
        .headOption()
        .flatMap((c) =>
            c.listChildren<ParameterElement>().headOption().map((p) => p.type));

    var res = StringBuffer();
    res
      ..writeln("// Class ${el.name}")
      ..writeln(_printElementsTree(visitor.result))
      ..writeln()
      ..writeln(
          "// First constructor param type: ${firstContructorParam.map((x) => x.element.getDisplayString(withNullability: true)).getOrElse("<none>")}")
      ..writeln();
    return res.toString();
  }
}
