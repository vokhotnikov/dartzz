import '../common/kind.dart';
import '../data/option.dart';

import 'semigroup.dart';
import 'monoid.dart';

abstract class Foldable<F> {
  const Foldable();

  A fold<A>(Kind<F, A> fa, Monoid<A> ev);

  Option<A> reduce<A>(Kind<F, A> fa, Semigroup<A> ev);
}