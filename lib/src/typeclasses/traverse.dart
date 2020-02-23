import '../common/kind.dart';

import 'functor.dart';
import 'applicative.dart';
import 'monad.dart';

import '../data/id.dart';
import '../instances/id_instances.dart';

abstract class Traverse<F> extends Functor<F> {
  const Traverse();

  Kind<G, Kind<F, B>> traverse<G, A, B>(
      Kind<F, A> fa, FlatMapAction<G, A, B> mapper, Applicative<G> ap);

  Kind<G, Kind<F, A>> sequence<G, A>(Kind<F, Kind<G, A>> fa, Applicative<G> ap) {
    return traverse(fa, (Kind<G, A> x) => x, ap);
  }

  @override
  Kind<F, B> map<A, B>(Kind<F, A> fa, MapAction<A, B> mapper) {
    return traverse(fa, (a) => Id(mapper(a)), IdInstances().applicative).fix().value;
  }
}
