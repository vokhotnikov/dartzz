import '../common/kind.dart';

abstract class Functor<F> {
  const Functor();

  Kind<F, B> map<A, B>(Kind<F, A> f, B mapper(A value));
}