import '../common/kind.dart';
import 'functor.dart';

abstract class Apply<F> extends Functor<F> {
  const Apply();

  Kind<F,B> ap<A, B>(Kind<F, MapAction<A, B>> ff, Kind<F, A> fa);
}

abstract class Applicative<F> extends Apply<F> {
  const Applicative();

  Kind<F, A> pure<A>(A a);

  @override
  Kind<F, B> map<A, B>(Kind<F, A> fa, MapAction<A, B> mapper) {
    return ap(pure(mapper), fa);
  }
}