import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

import 'typeclasses.dart';

part 'option_instances.zzsyntax.dart';

@immutable
@typeclassInstance
class OptionInstanceForTesting<A> extends TypeclassForTesting<Option<A>> {
  final TypeclassForTesting<A> innerInstance;

  const OptionInstanceForTesting(this.innerInstance);

  @override
  bool equalTo(Kind<ForOption, A> me, Kind<ForOption, A> other) {
    return me.fix().foldOption(
        () => other.fix().foldOption(() => true, (a) => false),
        (a) => other
            .fix()
            .foldOption(() => false, (b) => innerInstance.equalTo(a, b)));
  }

  @override
  String toStr(Kind<ForOption, A> me) {
    return me
        .fix()
        .foldOption(() => "none", (a) => "some ${innerInstance.toStr(a)}");
  }
}

@immutable
@typeclassInstance
class OptionFilteringFunctorForTesting
    extends FilteringFunctorForTesting<ForOption> {
  const OptionFilteringFunctorForTesting();

  @override
  Kind<ForOption, B> map<A, B>(Kind<ForOption, A> f, Func1<B, A> mapper) {
    return f.fix().foldOption(() => None<B>(), (a) => Some(mapper(a)));
  }

  @override
  Kind<ForOption, B> filterMap<A, B>(
      Kind<ForOption, A> f, Func1<bool, A> predicate, Func1<B, A> mapper) {
    return f.fix().foldOption(
        () => None<B>(), (a) => predicate(a) ? Some(mapper(a)) : None<B>());
  }
}

// expected to generate:
/* done
extension Option__FunctorFotTesting__Ext<A> on Option<A> {
  static const syntax =
      FunctorForTestingSyntax<ForOption>(OptionFunctorForTesting());

  Option<B> xmap<B>(Func1<B, A> mapper) => syntax.xmap(this, mapper).fix();
}
*/

/*
extension Option__TypeclassForTesting__Ext<A> on Option<A> {
  bool isEqTo1(TypeclassForTesting<A> innerInstance, Option<A> other) =>
      OptionInstanceForTesting<A>(innerInstance).equalTo(this, other);

  String asString1(TypeclassForTesting<A> innerInstance) =>
      OptionInstanceForTesting(innerInstance).toStr(this);
}
*/
