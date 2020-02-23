import 'semigroup.dart';

abstract class Monoid<A> extends Semigroup<A> {
  const Monoid();

  A get empty;
}