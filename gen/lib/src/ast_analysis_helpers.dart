import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';
import 'package:source_gen/source_gen.dart';

import 'codegen/codegen_model.dart';

ReferencedType referencedTypeFromDartType(DartType t) {
  return ReferencedType(
      typeNameForPossibleProto(t),
      t is ParameterizedType
          ? t.typeArguments.k().map(referencedTypeFromDartType)
          : <ReferencedType>[].k());
}

FunctionOrMethod parseFunctionOrMethod(MethodElement methodElement) {
  return FunctionOrMethod(
      methodElement.name,
      referencedTypeFromDartType(methodElement.returnType),
      methodElement.typeParameters.k().map((a) => GenericTypeArg(a.name,
          Option.fromNullable(a.bound).map(referencedTypeFromDartType))),
      methodElement.parameters.k().map(
          (p) => FunctionParameter(p.name, referencedTypeFromDartType(p.type))),
      CodeChunk(""));
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
