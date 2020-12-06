import 'typeclasses.dart';
import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

part 'either_instances.zzsyntax.dart';

@immutable
@typeclassInstance
class EitherInstanceForTesting<L>
    extends FunctorForTesting<Kind<ForEither, L>> {
  @override
  Kind<Kind<ForEither, L>, B> map<A, B>(
      Kind<Kind<ForEither, L>, A> f, Func1<B, A> mapper) {
    return f
        .fix()
        .foldEither((a) => Left<L, B>(a), (b) => Right<L, B>(mapper(b)));
  }
}
