import '../common/kind.dart';

typedef B MapAction<A, B>(A a);

abstract class Functor<F> {
  const Functor();

  Kind<F, B> map<A, B>(Kind<F, A> f, MapAction<A, B> mapper);
}
