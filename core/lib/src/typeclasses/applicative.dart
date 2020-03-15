import '../common/kind.dart';
import '../data/tuples.dart';
import 'functor.dart';

abstract class Apply<F> extends Functor<F> {
  const Apply();

  Kind<F,B> ap<A, B>(Kind<F, A> fa, Kind<F, MapAction<A, B>> ff);
}

abstract class Applicative<F> extends Apply<F> {
  const Applicative();

  Kind<F, A> pure<A>(A a);

  Kind<F, Tuple2<A, B>> product<A, B>(Kind<F, A> fa, Kind<F, B> fb) {
    return ap(fb, ap(fa, pure((a) => ((b) => Tuple2<A, B>(a, b)))));
  }

  @override
  Kind<F, B> map<A, B>(Kind<F, A> fa, MapAction<A, B> mapper) {
    return ap(fa, pure(mapper));
  }

  Kind<F, Tuple3<A, B, C>> product3<A, B, C>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc) =>
    map(product(product(fa, fb), fc), (nt) => Tuple3<A, B, C>(nt.it1.it1, nt.it1.it2, nt.it2));

  Kind<F, Tuple4<A, B, C, D>> product4<A, B, C, D>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc, Kind<F, D> fd) =>
    map(product(product(product(fa, fb), fc), fd), (nt) => Tuple4<A, B, C, D>(nt.it1.it1.it1, nt.it1.it1.it2, nt.it1.it2, nt.it2));

  Kind<F, Tuple5<A, B, C, D, E>> product5<A, B, C, D, E>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc, Kind<F, D> fd, Kind<F, E> fe) =>
    map(product(product(product(product(fa, fb), fc), fd), fe), (nt) => Tuple5<A, B, C, D, E>(nt.it1.it1.it1.it1, nt.it1.it1.it1.it2, nt.it1.it1.it2, nt.it1.it2, nt.it2));

  Kind<F, R> map2<A, B, R>(Kind<F, A> fa, Kind<F, B> fb, R mapper(A a, B b)) => 
    map(product(fa, fb), (t) => mapper(t.it1, t.it2));

  Kind<F, R> map3<A, B, C, R>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc, R mapper(A a, B b, C c)) => 
    map(product3(fa, fb, fc), (t) => mapper(t.it1, t.it2, t.it3));

  Kind<F, R> map4<A, B, C, D, R>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc, Kind<F, D> fd, R mapper(A a, B b, C c, D d)) => 
    map(product4(fa, fb, fc, fd), (t) => mapper(t.it1, t.it2, t.it3, t.it4));

  Kind<F, R> map5<A, B, C, D, E, R>(Kind<F, A> fa, Kind<F, B> fb, Kind<F, C> fc, Kind<F, D> fd, Kind<F, E> fe, R mapper(A a, B b, C c, D d, E e)) => 
    map(product5(fa, fb, fc, fd, fe), (t) => mapper(t.it1, t.it2, t.it3, t.it4, t.it5));
}