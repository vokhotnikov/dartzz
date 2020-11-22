import 'package:dartzz_core/dartzz_core.dart';
import 'package:dartzz_gen/src/codegen/codegen_model.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:meta/meta.dart';

@typeclass()
@immutable
abstract class CodegenSource<A> {
  const CodegenSource();

  ListK<CodeChunk> generateCode(A a);
}

typedef ListK<CodeChunk> CodegenSourceFunc<A>(A a);

@immutable
class _FuncCodegenSourceInstance<A> extends CodegenSource<A> {
  final CodegenSourceFunc<A> _func;

  const _FuncCodegenSourceInstance(this._func);

  @override
  ListK<CodeChunk> generateCode(A a) => _func(a);
}

@immutable
class CodegenSourceInstances {
  CodeChunk code(String code) => CodeChunk(code);

  CodeChunk space() => code(" ");

  CodeChunk newline() => code('\n');

  ListK<CodeChunk> intersperse(ListK<ListK<CodeChunk>> parts, CodeChunk start,
      CodeChunk separator, CodeChunk end) {
    return [
      start,
      ...parts
          .zipWithIndex()
          .flatMap((idxAndCs) => (idxAndCs.it1 == 0)
              ? idxAndCs.it2
              : idxAndCs.it2.prepend(separator))
          .toList(),
      end
    ].k();
  }

  CodegenSource<A> func<A>(CodegenSourceFunc<A> f) =>
      _FuncCodegenSourceInstance<A>(f);

  CodegenSource<GenericTypeArg> get genericTypeArgSource => func((a) => [
        code("${a.name}" + a.boundName.map((b) => " extends $b").getOrElse(""))
      ].k());

  CodegenSource<ReferencedType> get referencedTypeSource => func((t) => [
        code(t.name),
        ...t.typeArgs.isEmpty
            ? <CodeChunk>[]
            : intersperse(
                    t.typeArgs.map((a) => referencedTypeSource.generateCode(a)),
                    code("<"),
                    code(","),
                    code(">"))
                .toList()
      ].k());

  CodegenSource<ImmutableField> get immutableFieldSource => func((f) => ListK([
        [code("final"), space()].k(),
        referencedTypeSource.generateCode(f.type),
        [space(), code(f.name), code(";")].k()
      ]).flatten());
}
