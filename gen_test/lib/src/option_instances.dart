import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

import 'typeclasses.dart';

part 'option_instances.zzsyntax.dart';

@immutable
@typeclassInstance
class OptionInstanceForTesting<A>
    extends TypeclassForTesting<Kind<ForOption, A>> {
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
class OptionFunctorForTesting extends FunctorForTesting<ForOption> {
  const OptionFunctorForTesting();

  @override
  Kind<ForOption, B> map<A, B>(Kind<ForOption, A> f, mapper) {
    return f.fix().foldOption(() => None<B>(), (a) => Some(mapper(a)));
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
