import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'visitors/extract_children.dart';
import 'visitors/reflect_element_tree.dart';

class CaseClassesGenerator extends GeneratorForAnnotation<caseClass> {
  const CaseClassesGenerator();

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.name.startsWith('_')) {
      final reflectVisitor = ReflectElementTreeVisitor(element);
      element.visitChildren(reflectVisitor);

      final constructors = element.listChildren<ConstructorElement>().toList();
      if (constructors.length != 1) {
        throw InvalidGenerationSourceError("@caseclass class must have exactly one constructor, but ${element.name} has ${constructors.length}");
      }

      final typeparams = element.listChildren<TypeParameterElement>().toList();

      final parameters = constructors[0].listChildren<ParameterElement>().map((e) => _ParameterInfo(e.name, e.type)).toList();

      final className = element.name.substring(1);
      final res = StringBuffer();
      res
        ..writeln("@immutable")
        ..write("class $className")
        ..write(_typeParametersDeclaration(typeparams))
        ..writeln(" {")
        ..writeAll(parameters.map((p) => "  final ${_maybeCaseClassName(p.dartType)}${_typeArguments(p.typeArgs.toList())} ${p.name}; // ${p.dartType is ParameterizedType}"), "\n")
        ..writeln()
        ..writeln()
        ..writeln("@protected")
        ..writeln("Type get zz__proto => ${element.name};")
        ..writeln()
        ..write("  const $className(")
        ..writeAll(parameters.map((p) => "this.${p.name}"), ",")
        ..writeln(");")
        ..writeln()
        ..writeln("  @override")
        ..writeln("  String toString() {")
        ..write("    return \"$className(")
        ..writeAll(parameters.map((p) => "\${${p.name}.toString()}"), ", ")
        ..writeln(")\";")
        ..writeln("  }")
        ..writeln()
        ..writeln("  @override")
        ..writeln("  bool operator==(Object other) {")
        ..writeln("    return other is $className &&")
        ..writeAll(parameters.map((p) => "      ${p.name} == other.${p.name}"), " && ")
        ..writeln(";")
        ..writeln("  }")
        ..writeln("// elements tree:")
        ..writeln("${_printElementsTree(reflectVisitor.result)}")
        ..writeln("}");
      return res.toString();
    } else {
      throw InvalidGenerationSourceError("Classes marked with @caseclass should be private (start with _): ${element.name}");
    }
  }
  
  String _nameFromProtoName(String protoName) => protoName.substring(1);

  String _maybeCaseClassName(DartType t) {
    if (TypeChecker.fromRuntime(caseClass).hasAnnotationOfExact(t.element)) {
      return _nameFromProtoName(t.element.name);
    } else {
      return t.element.name;
    }
  }

  String _typeParametersDeclaration(List<TypeParameterElement> elements) =>
    elements.isNotEmpty ? "<" + elements.map((el) => el.bound == null ? el.name : "${el.name} extends ${el.bound}").join(", ") + ">" : "";

  String _typeArguments(List<DartType> types) =>
    types.isNotEmpty ? "<" + types.map((t) => _maybeCaseClassName(t)).join(", ") + ">" : "";

  String _printElementsTree(List<ElementWithLevel> elements) {
    var b = StringBuffer();
    b.writeAll(elements.map((e) => "// ${' '*e.depthLevel}${e.element.runtimeType} ${e.element.name} (${e.element.toString()})"), '\n');
    return b.toString();
  }
}

class _ParameterInfo {
  final String name;
  final DartType dartType;
  
  ListK<DartType> get typeArgs {
    final dt = dartType;
    return ListK((dt is ParameterizedType) ? dt.typeArguments : <DartType>[]);
  }

  const _ParameterInfo(this.name, this.dartType);
}

