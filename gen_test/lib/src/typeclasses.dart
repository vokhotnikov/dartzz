import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

@typeclass
@withTypeclassSyntax(TypeclassForTestingSyntax)
abstract class TypeclassForTesting<F> {
  const TypeclassForTesting();

  String toStr(F me);

  bool equalTo(F me, F other);
}

@immutable
@typeclassSyntax
class TypeclassForTestingSyntax<F> {
  final TypeclassForTesting<F> instance;

  const TypeclassForTestingSyntax(this.instance);

  String asString(F f) => instance.toStr(f);

  bool isEqTo(F me, F other) => instance.equalTo(me, other);
}

@typeclass
@withTypeclassSyntax(FunctorForTestingSyntax)
abstract class FunctorForTesting<F> {
  const FunctorForTesting();

  Kind<F, B> map<A, B>(Kind<F, A> f, Func1<B, A> mapper);
}

@typeclassSyntax
class FunctorForTestingSyntax<F> {
  final FunctorForTesting<F> instance;

  const FunctorForTestingSyntax(this.instance);

  Kind<F, B> xmap<A, B>(Kind<F, A> f, Func1<B, A> mapper) =>
      instance.map(f, mapper);
}
