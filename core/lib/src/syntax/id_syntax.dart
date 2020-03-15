import '../common/helpers.dart';
import '../data/id.dart';
import '../instances/id_instances.dart';
import '../typeclasses/functor.dart';

extension IdSyntaxExt<A> on Id<A> {
  // functor
  Id<B> map<B>(B mapper(A a)) {
    return IdInstances().functor.map(this, mapper).fix();
  }

  // applicative
  Id<B> ap<B>(Id<MapAction<A, B>> ff) {
    return IdInstances().applicative.ap(this, ff).fix();
  }

  // monad
  Id<B> flatMap<B>(Id<B> mapper(A a)) {
    return IdInstances().monad.flatMap(this, mapper).fix();
  }
}

extension IdIdSyntaxExt<A> on Id<Id<A>> {
  Id<A> flatten() {
    return this.flatMap(identity);
  }
}