import '../common/kind.dart';
import '../data/option.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';
import '../typeclasses/show.dart';
import '../typeclasses/filterable.dart';

class _ShowForOptionInstance<A> extends Show<Kind<ForOption, A>> {
  final Show<A> innerShow;

  const _ShowForOptionInstance(this.innerShow);

  @override
  String show(Kind<ForOption, A> f) {
    return f.fix().foldOption(() => "None", (v) => "Some(${innerShow.show(v)})");
  }
}

class _MonadForOptionInstance extends Monad<ForOption> {
  const _MonadForOptionInstance();

  @override
  Kind<ForOption, A> pure<A>(A a) {
    return Some(a);
  }

  @override
  Kind<ForOption, B> flatMap<A, B>(Kind<ForOption, A> fa, FlatMapAction<ForOption, A, B> mapper) {
    return fa.fix().foldOption(() => None<B>(), (v) => mapper(v));
  }
}

class _FilterableForOptionInstance extends Filterable<ForOption> {
  const _FilterableForOptionInstance();

  @override
  Kind<ForOption, A> filter<A>(Kind<ForOption, A> fa, bool Function(A a) predicate) {
    return fa.fix().foldOption(() => None<A>(), (v) => predicate(v) ? Some(v) : None<A>());
  }
}

class OptionInstances {
  const OptionInstances();

  final Functor<ForOption> functor = const _MonadForOptionInstance();
  final Applicative<ForOption> applicative = const _MonadForOptionInstance();
  final Monad<ForOption> monad = const _MonadForOptionInstance();
  final Filterable<ForOption> filterable = const _FilterableForOptionInstance();

  Show<Kind<ForOption, A>> show<A>(Show<A> innerShow) {
    return _ShowForOptionInstance(innerShow);
  }
}
