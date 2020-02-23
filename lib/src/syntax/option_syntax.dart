import '../data/option.dart';
import '../typeclasses/show.dart';
import '../instances/option_instances.dart';

extension OptionSyntaxExt<A> on Option<A> {
  // functor
  Option<B> map<B>(B mapper(A a)) {
    return OptionInstances().functor.map(this, mapper).fix();
  }

  // show
  String show(Show<A> innerShow) {
    return OptionInstances().show(innerShow).show(this);
  }
}

