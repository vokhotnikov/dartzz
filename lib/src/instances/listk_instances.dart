import '../common/kind.dart';
import '../data/listk.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';
import '../typeclasses/filterable.dart';

class _MonadForListKInstance extends Monad<ForListK> {
  const _MonadForListKInstance();

    @override
  Kind<ForListK, A> pure<A>(A a) {
    return ListK([a]);
  }

  @override
  Kind<ForListK, B> flatMap<A, B>(Kind<ForListK, A> fa, FlatMapAction<ForListK, A, B> mapper) {
    return ListK(fa.fix().toList().expand((a) => mapper(a).fix().toList()).toList());
  }
}

class _FilterableForListKInstance extends Filterable<ForListK> {
  const _FilterableForListKInstance();

  @override
  Kind<ForListK, A> filter<A>(Kind<ForListK, A> fa, bool Function(A a) predicate) {
    return ListK(fa.fix().toList().where(predicate).toList());
  }
}

class ListKInstances {
  const ListKInstances();

  final Functor<ForListK> functor = const _MonadForListKInstance();
  final Applicative<ForListK> applicative = const _MonadForListKInstance();
  final Monad<ForListK> monad = const _MonadForListKInstance();
  final Filterable<ForListK> filterable = const _FilterableForListKInstance();
}