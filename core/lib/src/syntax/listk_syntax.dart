import '../common/kind.dart';
import '../common/helpers.dart';
import '../data/listk.dart';
import '../data/option.dart';
import '../instances/listk_instances.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';
import '../typeclasses/semigroup.dart';
import '../typeclasses/monoid.dart';

extension ListKSyntaxExt<A> on ListK<A> {
  // functor
  ListK<B> map<B>(B mapper(A a)) {
    return ListKInstances().functor.map(this, mapper).fix();
  }

  // applicative
  ListK<B> ap<B>(ListK<MapAction<A, B>> ff) {
    return ListKInstances().applicative.ap(this, ff).fix();
  }

  // monad
  ListK<B> flatMap<B>(ListK<B> mapper(A a)) {
    return ListKInstances().monad.flatMap(this, mapper).fix();
  }

  // filter
  ListK<A> filter(bool predicate(A a)) {
    return ListKInstances().filterable.filter(this, predicate).fix();
  }

  // foldable
  A fold(Monoid<A> ev) => ListKInstances().foldable.fold(this, ev);

  Option<A> reduce(Semigroup<A> ev) =>
      ListKInstances().foldable.reduce(this, ev);

  Kind<G, Kind<ForListK, B>> traverse<G, B>(
      FlatMapAction<G, A, B> mapper, Applicative<G> ap) {
    return ListKInstances().traverse.traverse(this, mapper, ap);
  }
}

extension ListKListKSyntaxExt<A> on ListK<ListK<A>> {
  ListK<A> flatten() {
    return this.flatMap(identity);
  }
}

extension ListKOptionSyntaxExt<A> on ListK<Option<A>> {
  ListK<A> flatten() {
    return this
        .map((o) => o.foldOption(() => <A>[].k(), (v) => [v].k()))
        .flatten();
  }
}

extension WrappedListExt<A> on List<A> {
  ListK<A> k() {
    return ListK(this);
  }
}
