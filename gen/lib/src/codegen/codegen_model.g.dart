// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codegen_model.dart';

// **************************************************************************
// CaseClassesGenerator
// **************************************************************************

@immutable
class CodeChunk {
  final String code; // true

  @protected
  Type get zz__proto => _CodeChunk;

  const CodeChunk(this.code);

  @override
  String toString() {
    return "CodeChunk(${code.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is CodeChunk && code == other.code;
  }
// elements tree:
//  ConstructorElementImpl  (_CodeChunk _CodeChunk(String code))
//   ParameterElementImpl code (String code)
}

@immutable
class GenericTypeArg {
  final String name; // true
  final Option<String> boundName; // true

  @protected
  Type get zz__proto => _GenericTypeArg;

  const GenericTypeArg(this.name, this.boundName);

  @override
  String toString() {
    return "GenericTypeArg(${name.toString()}, ${boundName.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is GenericTypeArg &&
        name == other.name &&
        boundName == other.boundName;
  }
// elements tree:
//  ConstructorElementImpl  (_GenericTypeArg _GenericTypeArg(String name, Option<String> boundName))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl boundName (Option<String> boundName)
}

@immutable
class ReferencedType {
  final String name; // true
  final ListK<ReferencedType> typeArgs; // true

  @protected
  Type get zz__proto => _ReferencedType;

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
// elements tree:
//  ConstructorElementImpl  (_ReferencedType _ReferencedType(String name, ListK<_ReferencedType> typeArgs))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl typeArgs (ListK<_ReferencedType> typeArgs)
}

@immutable
class ImmutableField {
  final String name; // true
  final ReferencedType type; // true

  @protected
  Type get zz__proto => _ImmutableField;

  const ImmutableField(this.name, this.type);

  @override
  String toString() {
    return "ImmutableField(${name.toString()}, ${type.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is ImmutableField && name == other.name && type == other.type;
  }
// elements tree:
//  ConstructorElementImpl  (_ImmutableField _ImmutableField(String name, _ReferencedType type))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl type (_ReferencedType type)
}

@immutable
class FunctionParameter {
  final String name; // true
  final ReferencedType type; // true

  @protected
  Type get zz__proto => _FunctionParameter;

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
// elements tree:
//  ConstructorElementImpl  (_FunctionParameter _FunctionParameter(String name, _ReferencedType type))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl type (_ReferencedType type)
}

@immutable
class FunctionOrMethod {
  final String name; // true
  final ListK<GenericTypeArg> genericParams; // true
  final ListK<FunctionParameter> parameters; // true
  final CodeChunk body; // true

  @protected
  Type get zz__proto => _FunctionOrMethod;

  const FunctionOrMethod(
      this.name, this.genericParams, this.parameters, this.body);

  @override
  String toString() {
    return "FunctionOrMethod(${name.toString()}, ${genericParams.toString()}, ${parameters.toString()}, ${body.toString()})";
  }

  @override
  bool operator ==(Object other) {
    return other is FunctionOrMethod &&
        name == other.name &&
        genericParams == other.genericParams &&
        parameters == other.parameters &&
        body == other.body;
  }
// elements tree:
//  ConstructorElementImpl  (_FunctionOrMethod _FunctionOrMethod(String name, ListK<_GenericTypeArg> genericParams, ListK<_FunctionParameter> parameters, _CodeChunk body))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl genericParams (ListK<_GenericTypeArg> genericParams)
//   ParameterElementImpl parameters (ListK<_FunctionParameter> parameters)
//   ParameterElementImpl body (_CodeChunk body)
}

@immutable
class CaseClassCode {
  final String name; // true
  final ListK<GenericTypeArg> genericArgs; // true
  final ListK<ImmutableField> fields; // true
  final ListK<FunctionOrMethod> methods; // true

  @protected
  Type get zz__proto => _CaseClassCode;

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
// elements tree:
//  ConstructorElementImpl  (_CaseClassCode _CaseClassCode(String name, ListK<_GenericTypeArg> genericArgs, ListK<_ImmutableField> fields, ListK<_FunctionOrMethod> methods))
//   ParameterElementImpl name (String name)
//   ParameterElementImpl genericArgs (ListK<_GenericTypeArg> genericArgs)
//   ParameterElementImpl fields (ListK<_ImmutableField> fields)
//   ParameterElementImpl methods (ListK<_FunctionOrMethod> methods)
}
