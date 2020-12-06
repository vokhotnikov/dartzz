import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

@typeclass
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

@typeclass
abstract class FilteringFunctorForTesting<F> extends FunctorForTesting<F> {
  const FilteringFunctorForTesting();

  Kind<F, B> filterMap<A, B>(
      Kind<F, A> f, Func1<bool, A> predicate, Func1<B, A> mapper);
}

@typeclassSyntax
class FilteringFunctorForTestingSyntax<F> {
  final FilteringFunctorForTesting<F> instance;

  const FilteringFunctorForTestingSyntax(this.instance);

  Kind<F, B> xfmap<A, B>(
          Kind<F, A> f, Func1<bool, A> predicate, Func1<B, A> mapper) =>
      instance.filterMap(f, predicate, mapper);
}
