import '../common/helpers.dart';
import '../data/option.dart';
import '../data/tuples.dart';
import '../typeclasses/show.dart';
import '../typeclasses/functor.dart';

import '../instances/option_instances.dart';

extension OptionSyntaxExt<A> on Option<A> {
  // functor
  Option<B> map<B>(B mapper(A a)) {
    return OptionInstances().functor.map(this, mapper).fix();
  }

  // applicative
  Option<B> ap<B>(Option<MapAction<A, B>> ff) {
    return OptionInstances().applicative.ap(this, ff).fix();
  }

  Option<Tuple2<A, B>> product<B>(Option<B> fb) => OptionInstances().applicative.product(this, fb).fix();
  Option<Tuple3<A, B, C>> product3<B, C>(Option<B> fb, Option<C> fc) => OptionInstances().applicative.product3(this, fb, fc).fix();
  Option<Tuple4<A, B, C, D>> product4<B, C, D>(Option<B> fb, Option<C> fc, Option<D> fd) => OptionInstances().applicative.product4(this, fb, fc, fd).fix();
  Option<Tuple5<A, B, C, D, E>> product5<B, C, D, E>(Option<B> fb, Option<C> fc, Option<D> fd, Option<E> fe) => OptionInstances().applicative.product5(this, fb, fc, fd, fe).fix();

  // monad
  Option<B> flatMap<B>(Option<B> mapper(A a)) {
    return OptionInstances().monad.flatMap(this, mapper).fix();
  }

  // filter
  Option<A> filter(bool predicate(A a)) {
    return OptionInstances().filterable.filter(this, predicate).fix();
  }
  
  // show
  String show(Show<A> innerShow) {
    return OptionInstances().show(innerShow).show(this);
  }
}

extension OptionOptionSyntaxExt<A> on Option<Option<A>> {
  Option<A> flatten() {
    return OptionInstances().monad.flatMap(this, identity).fix();
  }
}
