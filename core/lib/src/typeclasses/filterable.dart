import '../common/kind.dart';

abstract class Filterable<F> {
  const Filterable();

  Kind<F, A> filter<A>(Kind<F, A> fa, bool predicate(A a));
}