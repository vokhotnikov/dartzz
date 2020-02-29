import '../common/helpers.dart';
import '../data/either.dart';
import '../typeclasses/show.dart';
import '../typeclasses/functor.dart';

import '../instances/either_instances.dart';

extension EitherSyntaxExt<L, A> on Either<L, A> {
  // functor
  Either<L, B> map<B>(B mapper(A a)) {
    return EitherInstances().functor.map(this, mapper).fix();
  }

  // applicative
  Either<L, B> ap<B>(Either<L, MapAction<A, B>> ff) {
    return EitherInstances().applicative.ap(this, ff).fix();
  }

  // monad
  Either<L, B> flatMap<B>(Either<L, B> mapper(A a)) {
    return EitherInstances().monad.flatMap(this, mapper).fix();
  }
  
  // show
  String show(Show<L> leftShow, Show<A> rightShow) {
    return EitherInstances().show(leftShow, rightShow).show(this);
  }
}

extension EitherEitherSyntaxExt<L, A> on Either<L, Either<L, A>> {
  Either<L, A> flatten() {
    return this.flatMap(identity);
  }
}
