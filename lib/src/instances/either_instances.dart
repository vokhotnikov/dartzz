import '../common/kind.dart';
import '../data/either.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/applicative.dart';
import '../typeclasses/monad.dart';
import '../typeclasses/show.dart';

class _ShowForEitherInstance<A, B> extends Show<Kind<Kind<ForEither, A>, B>> {
  final Show<A> leftShow;
  final Show<B> rightShow;

  const _ShowForEitherInstance(this.leftShow, this.rightShow);

  @override
  String show(Kind<Kind<ForEither, A>, B> f) {
    return f.fix().foldEither((l) => "Left(${leftShow.show(l)}", (v) => "Right(${rightShow.show(v)})");
  }
}

class _MonadForEitherInstance<L> extends Monad<Kind<ForEither, L>> {
  const _MonadForEitherInstance();

  @override
  Kind<Kind<ForEither, L>, A> pure<A>(A a) {
    return Right(a);
  }

  @override
  Kind<Kind<ForEither, L>, B> flatMap<A, B>(Kind<Kind<ForEither, L>, A> fa, FlatMapAction<Kind<ForEither, L>, A, B> mapper) {
    return fa.fix().foldEither((l) => Left(l), mapper);
  }
}

class EitherInstances<L> {
  EitherInstances();

  final Functor<Kind<ForEither, L>> functor = _MonadForEitherInstance<L>();
  final Applicative<Kind<ForEither, L>> applicative = _MonadForEitherInstance<L>();
  final Monad<Kind<ForEither, L>> monad = _MonadForEitherInstance<L>();

  Show<Kind<Kind<ForEither, L>, A>> show<A>(Show<L> leftShow, Show<A> rightShow) {
    return _ShowForEitherInstance(leftShow, rightShow);
  }
}
