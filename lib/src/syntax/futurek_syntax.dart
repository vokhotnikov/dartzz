import '../common/helpers.dart';
import '../data/futurek.dart';
import '../instances/futurek_instances.dart';
import '../typeclasses/functor.dart';

extension FutureKSyntaxExt<A> on FutureK<A> {
  // functor
  FutureK<B> map<B>(B mapper(A a)) {
    return FutureKInstances().functor.map(this, mapper).fix();
  }

  // applicative
  FutureK<B> ap<B>(FutureK<MapAction<A, B>> ff) {
    return FutureKInstances().applicative.ap(this, ff).fix();
  }

  // monad
  FutureK<B> flatMap<B>(FutureK<B> mapper(A a)) {
    return FutureKInstances().monad.flatMap(this, mapper).fix();
  }
}

extension FutureKFutureKSyntaxExt<A> on FutureK<FutureK<A>> {
  FutureK<A> flatten() {
    return this.flatMap(identity);
  }
}

extension WrappedFutureExt<A> on Future<A> {
  FutureK<A> k() { return FutureK(this); }
}