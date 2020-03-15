import 'package:dartzz_core/dartzz_core.dart';
import 'package:dartzz_gen/src/codegen/codegen_model.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CodegenOutput {
  const CodegenOutput();
}

@immutable
class CodegenNewline extends CodegenOutput {
  const CodegenNewline();
}

@immutable
class CodegenCode extends CodegenOutput {
  final CodeChunk chunk;

  const CodegenCode(this.chunk);
}

@typeclass()
@immutable
abstract class CodegenSource<A> {
  const CodegenSource();

  ListK<CodegenOutput> generateCode(A a);
}

typedef ListK<CodegenOutput> CodegenSourceFunc<A>(A a);

@immutable
class _FuncCodegenSourceInstance<A> extends CodegenSource<A> {
  final CodegenSourceFunc<A> _func;

  const _FuncCodegenSourceInstance(this._func);

  @override
  ListK<CodegenOutput> generateCode(A a) => _func(a);
}

@immutable
class CodegenSourceInstances {
  static CodegenOutput _code(String code) => CodegenCode(CodeChunk(code));
  
  static CodegenOutput _space() => _code(" ");

  static _func<A>(CodegenSourceFunc<A> f) => _FuncCodegenSourceInstance<A>(f);

  CodegenSource<CodeChunk> get _codeChunkSource => _func((c) => [CodegenCode(c)].k());

  CodegenSource<GenericTypeArg> get _genericTypeArgSource => _func((a) =>
   [_code("${a.name}" + a.boundName.map((b) => " extends $b").getOrElse(""))].k());

  CodegenSource<ReferencedType> get _referencedTypeSource => _func((t) => [_code(t.name)].k());

  CodegenSource<ImmutableField> get _immutableFieldSource => _func((f) => 
  ListK([
    [_code("final"), _space()].k(),
    _referencedTypeSource.generateCode(f.type),
    [_space(), _code(f.name), _code(";")].k()]).flatten());

}