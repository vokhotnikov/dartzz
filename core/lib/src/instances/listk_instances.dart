import '../common/kind.dart';
import '../data/listk.dart';
import '../data/option.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';
import '../typeclasses/filterable.dart';
import '../typeclasses/monoid.dart';
import '../typeclasses/semigroup.dart';
import '../typeclasses/foldable.dart';
import '../typeclasses/traverse.dart';
import '../syntax/option_syntax.dart';

class _MonadForListKInstance extends Monad<ForListK> {
  const _MonadForListKInstance();

    @override
  Kind<ForListK, A> pure<A>(A a) {
    return ListK([a]);
  }

  @override
  Kind<ForListK, B> flatMap<A, B>(Kind<ForListK, A> fa, FlatMapAction<ForListK, A, B> mapper) {
    return ListK(fa.fix().private__rawValue.expand((a) => mapper(a).fix().private__rawValue).toList());
  }
}

class _FilterableForListKInstance extends Filterable<ForListK> {
  const _FilterableForListKInstance();

  @override
  Kind<ForListK, A> filter<A>(Kind<ForListK, A> fa, bool Function(A a) predicate) {
    return ListK(fa.fix().private__rawValue.where(predicate).toList());
  }
}

class _FoldableForListKInstance extends Foldable<ForListK> {
  const _FoldableForListKInstance();

  @override
  A fold<A>(Kind<ForListK, A> fa, Monoid<A> ev) {
    return fa.fix().private__rawValue.fold(ev.empty, ev.combine);
  }

  @override
  Option<A> reduce<A>(Kind<ForListK, A> fa, Semigroup<A> ev) {
    return Some(fa.fix().private__rawValue).filter((l) => l.isNotEmpty).map((l) => l.reduce(ev.combine));
  }
}

class _TraverseForListKInstance extends Traverse<ForListK> {
  const _TraverseForListKInstance();

  @override
  Kind<G, Kind<ForListK, B>> traverse<G, A, B>(Kind<ForListK, A> fa, FlatMapAction<G, A, B> mapper, Applicative<G> ap) {
    return null;
  }
}

class ListKInstances {
  const ListKInstances();

  final Functor<ForListK> functor = const _MonadForListKInstance();
  final Applicative<ForListK> applicative = const _MonadForListKInstance();
  final Monad<ForListK> monad = const _MonadForListKInstance();
  final Filterable<ForListK> filterable = const _FilterableForListKInstance();
  final Foldable<ForListK> foldable = const _FoldableForListKInstance();
  final Traverse<ForListK> traverse = const _TraverseForListKInstance();
}