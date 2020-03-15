import '../common/kind.dart';
import '../typeclasses/applicative.dart';
import '../data/option.dart';
import '../data/either.dart';

extension ObjectSyntaxExt<A> on A {
  Kind<F, A> pure<F>(Applicative<F> ev) => ev.pure(this);

  Option<A> some() => Some<A>(this);
  Option<A> none() => None<A>();

  Either<A, B> asLeft<B>() => Left<A, B>(this);
  Either<B, A> asRight<B>() => Right<B, A>(this);
}

Option<A> none<A>() => None<A>();