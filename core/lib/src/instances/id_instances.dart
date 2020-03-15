import '../data/id.dart';
import '../common/kind.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';

class _MonadForIdInstance extends Monad<ForId> {
  const _MonadForIdInstance();

  @override
  Kind<ForId, A> pure<A>(A a) {
    return Id(a);
  }

  @override
  Kind<ForId, B> flatMap<A, B>(Kind<ForId, A> fa, FlatMapAction<ForId, A, B> mapper) {
    return mapper(fa.fix().value);
  }
}

class IdInstances {
  const IdInstances();

  final Monad<ForId> monad = const _MonadForIdInstance();
  final Applicative<ForId> applicative = const _MonadForIdInstance();
  final Functor<ForId> functor = const _MonadForIdInstance();
}