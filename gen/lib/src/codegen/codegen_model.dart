import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

part 'codegen_model.g.dart';

@caseClass()
class _CodeChunk { _CodeChunk(String code); }

@caseClass()
class _GenericTypeArg {
  _GenericTypeArg(String name, Option<String> boundName);
}

@caseClass()
class _ReferencedType {
  _ReferencedType(String name);
}

@caseClass()
class _ImmutableField {
  _ImmutableField(String name, _ReferencedType type);
}

@caseClass()
class _FunctionParameter {
  _FunctionParameter(String name, _ReferencedType type);
}

@caseClass()
class _FunctionOrMethod {
  _FunctionOrMethod(String name, ListK<_GenericTypeArg> genericParams, ListK<_FunctionParameter> parameters, _CodeChunk body);
}

@caseClass()
class _CaseClassCode {
  ListK<_GenericTypeArg> genericArgs;

  _CaseClassCode(String name, ListK<_GenericTypeArg> genericArgs, ListK<_ImmutableField> fields, ListK<_FunctionOrMethod> methods);
}