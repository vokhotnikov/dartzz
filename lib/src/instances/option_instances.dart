import 'package:dartzz/dartzz.dart';

import '../common/kind.dart';
import '../data/option.dart';
import '../typeclasses/functor.dart';
import '../typeclasses/show.dart';

class _ShowForOptionInstance<A> extends Show<Kind<ForOption, A>> {
  final Show<A> innerShow;

  const _ShowForOptionInstance(this.innerShow);

  @override
  String show(Kind<ForOption, A> f) {
    return f.fix().foldOption(() => "None", (v) => "Some(${innerShow.show(v)})");
  }
}

class _FunctorForOptionInstance extends Functor<ForOption> {
  const _FunctorForOptionInstance();

  @override
  Kind<ForOption, B> map<A, B>(Kind<ForOption, A> f, B mapper(A a)) {
    return f.fix().foldOption(() => None<B>(), (v) => Some(mapper(v)));
  }
}

class OptionInstances {
  const OptionInstances();

  final Functor<ForOption> functor = const _FunctorForOptionInstance();

  Show<Kind<ForOption, A>> show<A>(Show<A> innerShow) {
    return _ShowForOptionInstance(innerShow);
  }
}
