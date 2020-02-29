import '../common/helpers.dart';
import '../data/option.dart';
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
    return this.flatMap(identity);
  }
}
