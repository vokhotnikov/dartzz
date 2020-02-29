import '../common/helpers.dart';
import '../data/listk.dart';
import '../instances/listk_instances.dart';
import '../typeclasses/functor.dart';

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
}

extension ListKListKSyntaxExt<A> on ListK<ListK<A>> {
  ListK<A> flatten() {
    return this.flatMap(identity);
  }
}

extension WrappedListExt<A> on List<A> {
  ListK<A> k() { return ListK(this); }
}