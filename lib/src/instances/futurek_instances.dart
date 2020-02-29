import '../common/kind.dart';

import '../data/futurek.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';

class _MonadForFutureKInstance extends Monad<ForFutureK> {
  const _MonadForFutureKInstance();

  @override
  Kind<ForFutureK, B> flatMap<A, B>(Kind<ForFutureK, A> fa, mapper) {
    return FutureK(fa.fix().toFuture().then((a) => mapper(a).fix().toFuture()));
  }

  @override
  Kind<ForFutureK, A> pure<A>(A a) {
    return FutureK(Future.value(a));
  }
}

class FutureKInstances {
  const FutureKInstances();

  final Functor<ForFutureK> functor = const _MonadForFutureKInstance();
  final Applicative<ForFutureK> applicative = const _MonadForFutureKInstance();
  final Monad<ForFutureK> monad = const _MonadForFutureKInstance();
}