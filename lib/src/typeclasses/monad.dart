import '../common/kind.dart';

import 'functor.dart';
import 'applicative.dart';

typedef Kind<F, B> FlatMapAction<F, A, B>(A a);

abstract class Monad<F> extends Applicative<F> {
  const Monad();

  Kind<F, B> flatMap<A, B>(Kind<F, A> fa, FlatMapAction<F, A, B> mapper);

  Kind<F, A> flatten<A>(Kind<F, Kind<F, A>> ffa) {
    return flatMap(ffa, (Kind<F, A> x) => x);
  }

  @override
  Kind<F, B> map<A, B>(Kind<F, A> fa, MapAction<A, B> mapper) {
    return flatMap(fa, (a) => pure(mapper(a)));
  }
}