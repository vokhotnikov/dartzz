import 'package:meta/meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

@immutable
class CodeChunk {
  final String code;

  const CodeChunk(this.code);

  @override
  String toString() {
    return "CodeChunk(${code.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is CodeChunk && code == other.code;
  }
}

@immutable
class GenericTypeArg {
  final String name;
  final Option<ReferencedType> boundType;

  const GenericTypeArg(this.name, this.boundType);

  @override
  String toString() {
    return "GenericTypeArg(${name.toString()}, ${boundType.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is GenericTypeArg &&
        name == other.name &&
        boundType == other.boundType;
  }
}

@immutable
class ReferencedType {
  final String name;
  final ListK<ReferencedType> typeArgs;

  const ReferencedType(this.name, this.typeArgs);

  @override
  String toString() {
    return "ReferencedType(${name.toString()}, ${typeArgs.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is ReferencedType &&
        name == other.name &&
        typeArgs == other.typeArgs;
  }
}

@immutable
class ImmutableField {
  final String name;
  final ReferencedType type;

  const ImmutableField(this.name, this.type);

  @override
  String toString() {
    return "ImmutableField(${name.toString()}, ${type.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is ImmutableField && name == other.name && type == other.type;
  }
}

@immutable
class FunctionParameter {
  final String name;
  final ReferencedType type;

  const FunctionParameter(this.name, this.type);

  @override
  String toString() {
    return "FunctionParameter(${name.toString()}, ${type.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is FunctionParameter &&
        name == other.name &&
        type == other.type;
  }
}

@immutable
class FunctionOrMethod {
  final String name;
  final ReferencedType returnType;
  final ListK<GenericTypeArg> genericParams;
  final ListK<FunctionParameter> parameters;
  final CodeChunk body;

  const FunctionOrMethod(this.name, this.returnType, this.genericParams,
      this.parameters, this.body);

  @override
  String toString() {
    return "FunctionOrMethod(${returnType.toString()}, {name.toString()}, ${genericParams.toString()}, ${parameters.toString()}, ${body.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is FunctionOrMethod &&
        name == other.name &&
        returnType == other.returnType &&
        genericParams == other.genericParams &&
        parameters == other.parameters &&
        body == other.body;
  }
}

@immutable
class CaseClassCode {
  final String name;
  final ListK<GenericTypeArg> genericArgs;
  final ListK<ImmutableField> fields;
  final ListK<FunctionOrMethod> methods;

  const CaseClassCode(this.name, this.genericArgs, this.fields, this.methods);

  @override
  String toString() {
    return "CaseClassCode(${name.toString()}, ${genericArgs.toString()}, ${fields.toString()}, ${methods.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is CaseClassCode &&
        name == other.name &&
        genericArgs == other.genericArgs &&
        fields == other.fields &&
        methods == other.methods;
  }
}

@immutable
class TypeclassSyntaxProxyExtension {
  final ReferencedType subjectType;
  final ReferencedType typeclass;
  final ReferencedType instanceType;
  final ReferencedType syntaxType;
  final ListK<FunctionOrMethod> proxiedMethods;

  const TypeclassSyntaxProxyExtension(
      {@required this.subjectType,
      @required this.typeclass,
      @required this.instanceType,
      @required this.syntaxType,
      @required this.proxiedMethods});

  @override
  String toString() {
    return "TypeclassSyntaxProxyExtension(subject = ${subjectType.toString()}, typeclass = ${typeclass.toString()}, instance = ${instanceType.toString()}, syntax = ${syntaxType.toString()}";
  }

  @override
  bool operator ==(Object other) {
    return other is TypeclassSyntaxProxyExtension &&
        this.subjectType == other.subjectType &&
        this.typeclass == other.typeclass &&
        this.instanceType == other.instanceType &&
        this.syntaxType == other.syntaxType &&
        this.proxiedMethods == other.proxiedMethods;
  }
}
