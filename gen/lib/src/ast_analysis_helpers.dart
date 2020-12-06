import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:source_gen/source_gen.dart';

import 'codegen/codegen_model.dart';
import 'visitors/extract_children.dart';

ReferencedType referencedTypeFromDartType(DartType t) {
  if (t is FunctionType) {
    return ReferencedType(
        "Func${t.normalParameterTypes.length}",
        t.normalParameterTypes
            .k()
            .prepend(t.returnType)
            .map(referencedTypeFromDartType));
  }
  return ReferencedType(
      typeNameForPossibleProto(t),
      t is ParameterizedType
          ? t.typeArguments.k().map(referencedTypeFromDartType)
          : <ReferencedType>[].k());
}

FunctionOrMethod parseFunctionOrMethod(MethodElement methodElement) {
  FunctionParameter parseParameter(ParameterElement pe) {
    final tpes = pe.listChildren<TypeParameterElement>();
    if (tpes.length > 0) {
      final funcType = ReferencedType("Func${pe.typeParameters.length - 1}",
          tpes.map((tpe) => referencedTypeFromDartType(tpe.type)));
      return FunctionParameter(pe.name, funcType);
    }

    return FunctionParameter(pe.name, referencedTypeFromDartType(pe.type));
  }

  final returnType = referencedTypeFromDartType(methodElement.returnType);
  return FunctionOrMethod(
      methodElement.name,
      returnType,
      methodElement.typeParameters.k().map((a) => GenericTypeArg(a.name,
          Option.fromNullable(a.bound).map(referencedTypeFromDartType))),
      methodElement.parameters.k().map(parseParameter),
      none(),
      returnType.name == "Kind" && !returnType.typeArgs.isEmpty);
}

String typeNameForPossibleProto(DartType dartType) {
  if (TypeChecker.fromRuntime(
          CaseClassAnnotation) // TODO possibly will have to add new annotations
      .hasAnnotationOfExact(dartType.element)) {
    return dartType.element.name.substring(1);
  } else {
    return dartType.element.name;
  }
}

ListK<ClassElement> findClasses(
    LibraryElement library, Func1<bool, ClassElement> predicate) {
  return library.importedLibraries
      .followedBy([library])
      .expand((lib) =>
          lib.topLevelElements.whereType<ClassElement>().where(predicate))
      .toList()
      .k();
}
